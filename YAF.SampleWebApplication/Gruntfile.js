/**
 * Build process for YetAnotherForum.NET
 *
 * Don't know where to start?
 * Try: http://24ways.org/2013/grunt-is-not-weird-and-hard/
 */


module.exports = function(grunt) {

    // CONFIGURATION
    grunt.initConfig({
        pkg: grunt.file.readJSON("package.json"),

        downloadfile: {
            options: {
                dest: "./",
                overwriteEverytime: true
            },
            files: {
                'YAF.SqlServer-Upgrade.zip': "https://github.com/YAFNET/YAFNET/releases/download/v<%= pkg.version %>/YAF.SqlServer-v<%= pkg.version %>-Upgrade.zip"
            }
        },

        unzip: {
            "upgrade/": "YAF.SqlServer-Upgrade.zip"
        },

        shell: {
            delete: {
                command: [
                    "@echo off",
                    "rmdir upgrade /s /q ",
                    'del "YAF.SqlServer-Upgrade.zip"'
                ].join("&&")
            }
        },

        copy: {
            upgrade: {
                files: [
                    {
                        expand: true,
                        src: "**/*.dll",
                        cwd: "upgrade/bin",
                        dest: "bin/"
                    },
                    {
                        expand: true,
                        src: "**/*.*",
                        cwd: "upgrade/Content/",
                        dest: "forum/Content/"
                    },
                    {
                        expand: true,
                        src: "**/*.*",
                        cwd: "upgrade/Controls/",
                        dest: "forum/Controls/"
                    },
                    {
                        expand: true,
                        src: "**/*.*",
                        cwd: "upgrade/Dialogs/",
                        dest: "forum/Dialogs/"
                    },
                    {
                        expand: true,
                        src: "**/*.*",
                        cwd: "upgrade/Images/",
                        dest: "forum/Images/"
                    },
                    {
                        expand: true,
                        src: "**/*.*",
                        cwd: "upgrade/Install/",
                        dest: "forum/Install/"
                    },
                    {
                        expand: true,
                        src: "**/*.*",
                        cwd: "upgrade/Content/",
                        dest: "forum/Content/"
                    },
                    {
                        expand: true,
                        src: "**/*.*",
                        cwd: "upgrade/languages/",
                        dest: "forum/languages/"
                    },
                    {
                        expand: true,
                        src: "**/*.*",
                        cwd: "upgrade/Pages/",
                        dest: "forum/Pages/"
                    },
                    {
                        expand: true,
                        src: "**/*.*",
                        cwd: "upgrade/Resources/",
                        dest: "forum/Resources/"
                    },
                    {
                        expand: true,
                        src: "**/*.*",
                        cwd: "upgrade/Scripts/",
                        dest: "forum/Scripts/"
                    },
                    {
                        expand: true,
                        src: "**/error.aspx",
                        cwd: "upgrade/",
                        dest: "forum/"
                    }
                ]
            }
        },

        devUpdate: {
            main: {
                options: {
                    reportUpdated: true,
                    updateType: "force",
                    semver: false,
                    packages: {
                        devDependencies: true, //only check for devDependencies
                        dependencies: true
                    }
                }
            }
        }
    });

    // PLUGINS
    grunt.loadNpmTasks("grunt-contrib-copy");
    grunt.loadNpmTasks("grunt-dev-update");
    grunt.loadNpmTasks("grunt-zip");
    grunt.loadNpmTasks("grunt-downloadfile");
    grunt.loadNpmTasks("grunt-shell");

    grunt.registerTask("default",
        [
            "devUpdate", "downloadfile", "unzip", "copy", "shell"
        ]);
};
