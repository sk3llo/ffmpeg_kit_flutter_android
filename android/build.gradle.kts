plugins {
    id("com.android.library") version "8.12.3"
    id("org.jetbrains.kotlin.android") version "1.8.22"
    id("maven-publish")
    id("signing")
    id("com.vanniktech.maven.publish") version "0.34.0"
}

// Publishing [com.vanniktech.maven.publish] config
mavenPublishing {
    // Target the Central Portal (central.sonatype.com) and sign every publication.
    // Without these the plugin registers no publishToMavenCentral task at all.
    publishToMavenCentral()
    signAllPublications()

    coordinates("com.antonkarpenko", "ffmpeg-kit-audio", "2.2.2")

    pom {
        name.set("FFmpeg v8.1.1 Audio")
        description.set("FFmpeg v8.1.1 Audio")
        inceptionYear.set("2025")
        url.set("https://github.com/sk3llo/ffmpeg-kit-flutter")
        licenses {
            license {
                name.set("LGPL 3.0")
                url.set("https://www.gnu.org/licenses/lgpl-3.0.en.html")
                distribution.set("https://www.gnu.org/licenses/lgpl-3.0.en.html")
            }
            // GPL License
            license {
                name.set("GPL 3.0")
                url.set("https://www.gnu.org/licenses/gpl-3.0.en.html")
                distribution.set("https://www.gnu.org/licenses/gpl-3.0.en.html")
            }
        }
        developers {
            developer {
                id.set("sk3llo")
                name.set("Anton Karpenko")
                email.set("kapraton@gmail.com")
            }
        }
        scm {
            connection.set("scm:git:github.com/sk3llo/ffmpeg-kit-flutter.git")
            developerConnection.set("scm:git:ssh://github.com/sk3llo/ffmpeg-kit-flutter.git")
            url.set("https://github.com/sk3llo/ffmpeg-kit-flutter/tree/master")
        }
    }
}

android {
    namespace = "com.antonkarpenko"
    compileSdk = 36
    version = "2.2.2"

    defaultConfig {
        minSdk = 24
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        consumerProguardFiles("consumer-rules.pro")
    }

    buildTypes {
        release {
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

// Task to generate sources JAR
tasks.register<Jar>("sourcesJar") {
    from(android.sourceSets.getByName("main").java.srcDirs)
    archiveClassifier.set("sources")
}

// Only create Javadoc JAR if Dokka is available
val javadocJar by tasks.registering(Jar::class) {
    archiveClassifier.set("javadoc")
    // Skip if Dokka is not available
    val dokkaTask = tasks.findByName("dokkaJavadoc")
    if (dokkaTask != null) {
        from(dokkaTask)
    }
}

// Ensure the sources JAR is built during assemble
tasks.named("assemble") {
    dependsOn("sourcesJar")
}

// Publish task
tasks.withType<PublishToMavenRepository> {
    dependsOn(tasks.withType<Sign>())
}

// Signing Configuration
signing {
    val signingKey = providers.gradleProperty("signing.key")
    val signingPassword = providers.gradleProperty("signing.password")

    if (signingKey.isPresent && signingPassword.isPresent) {
        useInMemoryPgpKeys(signingKey.get(), signingPassword.get())
        sign(publishing.publications)
    } else {
        // Delegate to the local `gpg` binary (signing.gnupg.* properties).
        // GnuPG 2.4 key exports are unreadable by Gradle's BouncyCastle
        // ("PGPException: checksum mismatch") even with the right passphrase.
        useGpgCmd()
    }
}