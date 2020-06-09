package com.didi.virtualapk.demo.aidl;

import android.annotation.SuppressLint;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.RemoteException;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.EditText;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import com.didi.virtualapk.demo.socket.TCPClientActivity;
import java.util.List;
import sg.omi.R;

public class BookManagerActivity extends AppCompatActivity {

  private static final String TAG = "BookManagerActivity";
  private static final int MESSAGE_NEW_BOOK_ARRIVED = 1;
  private static final int PERMISSION_REQUEST_CODE_LOCATION = 20171222;

  private IBookManager mRemoteBookManager;
  private EditText mEditText;

  @SuppressLint("HandlerLeak")
  private Handler mHandler =
      new Handler() {
        @Override
        public void handleMessage(Message msg) {
          switch (msg.what) {
            case MESSAGE_NEW_BOOK_ARRIVED:
              Log.d(TAG, "receive new book :" + msg.obj);
              mEditText.append(msg.obj.toString() + "\n");
              break;
            default:
              super.handleMessage(msg);
          }
        }
      };

  private IBinder.DeathRecipient mDeathRecipient =
      new IBinder.DeathRecipient() {
        @Override
        public void binderDied() {
          Log.d(TAG, "binder died. tname:" + Thread.currentThread().getName());
          if (mRemoteBookManager == null) return;
          mRemoteBookManager.asBinder().unlinkToDeath(mDeathRecipient, 0);
          mRemoteBookManager = null;
          // TODO:这里重新绑定远程Service
        }
      };

  private ServiceConnection mConnection =
      new ServiceConnection() {
        public void onServiceConnected(ComponentName className, IBinder service) {
          IBookManager bookManager = IBookManager.Stub.asInterface(service);
          mRemoteBookManager = bookManager;
          try {
            mRemoteBookManager.asBinder().linkToDeath(mDeathRecipient, 0);
            List<Book> list = bookManager.getBookList();
            Log.i(TAG, "query book list, list type:" + list.getClass().getCanonicalName());
            Log.i(TAG, "query book list:" + list.toString());
            Book newBook = new Book(3, "Android进阶");
            bookManager.addBook(newBook);
            Log.i(TAG, "add book:" + newBook);
            List<Book> newList = bookManager.getBookList();
            Log.i(TAG, "query book list:" + newList.toString());
            bookManager.registerListener(mOnNewBookArrivedListener);
          } catch (RemoteException e) {
            e.printStackTrace();
          }
        }

        public void onServiceDisconnected(ComponentName className) {
          mRemoteBookManager = null;
          Log.d(TAG, "onServiceDisconnected. tname:" + Thread.currentThread().getName());
        }
      };

  private IOnNewBookArrivedListener mOnNewBookArrivedListener =
      new IOnNewBookArrivedListener.Stub() {

        @Override
        public void onNewBookArrived(Book newBook) throws RemoteException {
          mHandler.obtainMessage(MESSAGE_NEW_BOOK_ARRIVED, newBook).sendToTarget();
        }
      };

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_book_manager);
    mEditText = (EditText) findViewById(R.id.editText);
    Intent intent = new Intent(this, BookManagerService.class);
    bindService(intent, mConnection, Context.BIND_AUTO_CREATE);
    findViewById(R.id.request_permission)
        .setOnClickListener(
            new OnClickListener() {
              @Override
              public void onClick(View v) {
                Log.d("ady", "onClick: requestPermission");
                requestPermssion();
                //                requestPermissions(
                //                    new String[] {permission.ACCESS_FINE_LOCATION},
                //                    PERMISSION_REQUEST_CODE_LOCATION);
              }
            });
  }

  @Override
  public void onRequestPermissionsResult(
      int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
    Log.d("ady", "onRequestPermissionsResult: " + this);
    for (int i = 0; i < permissions.length; i++) {
      Log.d(
          "ady",
          "onRequestPermissionsResult: "
              + permissions[i]
              + ", "
              + (grantResults[i] == PackageManager.PERMISSION_GRANTED));
    }
    super.onRequestPermissionsResult(requestCode, permissions, grantResults);
  }

  public void requestPermssion() {
    Log.d("ady", "requestPermssion: this = " + this);
    startActivityForResult(
        new Intent()
            .setComponent(
                new ComponentName("com.p1.mobile.putong", "com.didi.virtualapk.PermissionActivity")),
        0x123);
  }

  @Override
  protected void onActivityResult(int requestCode, int resultCode, Intent data) {}

  public void onButton1Click(View view) {
    new Thread(
            new Runnable() {

              @Override
              public void run() {
                if (mRemoteBookManager != null) {
                  try {
                    List<Book> newList = mRemoteBookManager.getBookList();
                  } catch (RemoteException e) {
                    e.printStackTrace();
                  }
                }
              }
            })
        .start();

    Intent intent = new Intent(this, TCPClientActivity.class);
    startActivity(intent);
  }

  @Override
  protected void onDestroy() {
    if (mRemoteBookManager != null && mRemoteBookManager.asBinder().isBinderAlive()) {
      try {
        Log.i(TAG, "unregister listener:" + mOnNewBookArrivedListener);
        mRemoteBookManager.unregisterListener(mOnNewBookArrivedListener);
      } catch (RemoteException e) {
        e.printStackTrace();
      }
    }
    unbindService(mConnection);
    super.onDestroy();
  }
}
