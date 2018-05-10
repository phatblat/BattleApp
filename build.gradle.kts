/*
 * settings.gradle.kts
 * BattleApp
 */

import at.phatbl.shellexec.ShellExec

plugins {
    id("at.phatbl.clamp") version "1.1.0"
    id("at.phatbl.shellexec") version "1.1.3"
}

val crashlyticsApiKey by project
val crashlyticsBuildSecret by project

val crashlyticsDeploy by tasks.creating(ShellExec::class) {
    description = "Deploys the app to Crahlytics Beta."
    group = "👊🏻 BattleApp"
    command = """
        Pods/Crashlytics/submit $crashlyticsApiKey $crashlyticsBuildSecret \
        -ipaPath /path/to/my.ipa
        -notesPath RELEASENOTES.md \
        -groupAliases battleapp \
        -notifications YES
    """.trimIndent()
        // -emails TestEmail@fabric.io,AmazingTester@google.com \
}

val deploy by tasks.creating() {
    description = "Deploys the app."
    group = "👊🏻 BattleApp"
    dependsOn(crashlyticsDeploy)
}
