package com.didi.virtualapk.hooker

import com.android.build.gradle.api.ApkVariant
import com.android.build.gradle.internal.pipeline.TransformTask
import com.android.build.gradle.internal.transforms.DesugarTransform
import com.didi.virtualapk.utils.Log
import org.gradle.api.Project

/**
 * Apply host mapping file to maintain compatibility between the plugin and host apk.
 * And input the stripped jar files as library, to prevent proguard errors
 *
 * @author zhengtao
 */
class DesugarHooker extends GradleTaskHooker<TransformTask> {

    DesugarHooker(Project project, ApkVariant apkVariant) {
        super(project, apkVariant)
    }

    @Override
    String getTransformName() {
        return "desugar"
    }


    @Override
    void beforeTaskExecute(TransformTask task) {

        Log.i("VAPlugin", "DesugarHooker")

        def desugarTransform = task.transform as DesugarTransform
        Log.i('VAPlugin', 'desugarTransform = ' + desugarTransform.name + ',' + desugarTransform.incremental
                + ',' + desugarTransform.inputTypes + ',' + desugarTransform.parameterInputs + ',' + desugarTransform.referencedScopes
                + ',' + desugarTransform.scopes + ',' + desugarTransform.secondaryFiles)


//        vaContext.stripDependencies.each {
//            desugarTransform.libraryJar(it.jarFile)
//            if (it instanceof AarDependenceInfo) {
//                it.localJars.each {
//                    desugarTransform.libraryJar(it)
//                }
//            }
//        }
    }


    @Override
    void afterTaskExecute(TransformTask task) { }
}