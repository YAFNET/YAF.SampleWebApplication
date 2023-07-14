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

        copy: {
            emojionearea: {
                files: [
                    {
                        expand: true,
                        src: "emojionearea.min.js",
                        cwd: "node_modules/emojionearea/dist",
                        dest: "Scripts/"
                    },
                    {
                        expand: true,
                        src: "emojionearea.css",
                        cwd: "node_modules/emojionearea/dist",
                        dest: "Content/"
                    }
                ]
            },
            signalR: {
                files: [
                    {
                        expand: true,
                        src: "jquery.signalR.min.js",
                        cwd: "node_modules/signalr",
                        dest: "Scripts/"
                    }
                ]
            },
            jquerySlimScroll: {
                files: [
                    {
                        expand: true,
                        src: "jquery.slimscroll.min.js",
                        cwd: "node_modules/jquery-slimscroll",
                        dest: "Scripts/"
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

    grunt.registerTask("default",
        [
            "devUpdate", "copy"
        ]);
};
