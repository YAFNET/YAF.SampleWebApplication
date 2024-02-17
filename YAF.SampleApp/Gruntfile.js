/**
 * Build process for YetAnotherForum.NET
 *
 * Don't know where to start?
 * Try: http://24ways.org/2013/grunt-is-not-weird-and-hard/
 */

const lightBoxWebpackConfig = require('./wwwroot/lib/bs5-lightbox/webpack.cdn.js');
module.exports = function(grunt) {

    // CONFIGURATION
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),

        replace: {
            LayoutFileHeader: {
                options: {
                    usePrefix: false,
                    patterns: [
                        {
                            match: '<body id="YafBody">',
                            replacement: '<%= grunt.file.read("Pages/Shared/LayoutHeader.html") %>'
                        }
                    ]
                },
                files: [
                    {
                        expand: true,
                        flatten: true,
                        src: ['Areas/Forums/Pages/Shared/_Layout.cshtml'],
                        dest: 'Areas/Forums/Pages/Shared/'
                    }
                ]
            },
            LayoutFileFooter: {
                options: {
                    usePrefix: false,
                    patterns: [
                        {
                            match: '<script src="@(Current.Get<BoardInfo>().GetUrlToScripts($"{ViewBag.ForumJs}.js?v={ViewBag.CdvVersion}"))"></script>',
                            replacement: '<%= grunt.file.read("Pages/Shared/LayoutFooter.html") %>'
                        }
                    ]
                },
                files: [
                    {
                        expand: true,
                        flatten: true,
                        src: ['Areas/Forums/Pages/Shared/_Layout.cshtml'],
                        dest: 'Areas/Forums/Pages/Shared/'
                    }
                ]
            }
        },

        webpack: {
            lightBox: lightBoxWebpackConfig
        },

        downloadfile: {
            options: {
                dest: './',
                overwriteEverytime: true
            },
            files: {
                'master.zip': 'https://github.com/YAFNET/YAFNET/archive/refs/heads/master.zip'
            }
        },

        unzip: {
            "master/": 'master.zip'
        },

        shell: {
            delete: {
                command: [
                    '@echo off',
                    'rmdir master /s /q ',
                    'del "master.zip"'
                ].join('&&')
            }
        },

        copy: {
            updateYAF: {
                files: [
                    {
                        expand: true,
                        src: '**/*.*',
                        cwd: 'master/YAFNET-master/yafsrc/YetAnotherForum.NET/Pages',
                        dest: 'Areas/Forums/Pages'
                    },
                    {
                        expand: true,
                        src: '**/GlobalUsings.cs',
                        cwd: 'master/YAFNET-master/yafsrc/YetAnotherForum.NET',
                        dest: ''
                    },
                    {
                        expand: true,
                        src: 'helpMenu.json',
                        cwd: 'master/YAFNET-master/yafsrc/YetAnotherForum.NET',
                        dest: ''
                    },
                    {
                        expand: true,
                        src: 'mimeTypes.json',
                        cwd: 'master/YAFNET-master/yafsrc/YetAnotherForum.NET',
                        dest: ''
                    },
                    {
                        expand: true,
                        src: '**/*.*',
                        cwd: 'master/YAFNET-master/yafsrc/YetAnotherForum.NET/wwwroot/',
                        dest: 'wwwroot'
                    }
                ]
            }
        },

        // Minimize JS
        uglify: {
            installWizard: {
                options: {
                    sourceMap: false,
                    output: { beautify: true },
                    mangle: false,
                    compress: false
                },
                src: [
                    'wwwroot/lib/bootstrap.bundle.js',
                    'wwwroot/lib/forum/installWizard.js'
                ],
                dest: 'wwwroot/js/InstallWizard.comb.js'
            },

            codeMirror: {
                options: {
                    sourceMap: false,
                    output: { beautify: true },
                    mangle: false,
                    compress: false
                },
                src: [
                    'node_modules/codemirror/lib/codemirror.js',
                    'node_modules/codemirror/mode/sql/sql.js',
                    'node_modules/codemirror/addon/edit/matchbrackets.js',
                    'node_modules/codemirror/addon/hint/show-hint.js',
                    'node_modules/codemirror/addon/hint/sql-hint.js'
                ],
                dest: 'wwwroot/js/codemirror.min.js'
            },
            yafEditor: {
                options: {
                    sourceMap: false,
                    output: { beautify: true },
                    mangle: false,
                    compress: false
                },
                src: [
                    'wwwroot/lib/editor/editor.js',
                    'wwwroot/lib/editor/undoManager.js',
                    'wwwroot/lib/editor/autoCloseTags.js',
                    'wwwroot/lib/editor/mentions.js'
                ],
                dest: 'wwwroot/js/editor.comb.js'
            },
            SCEditor: {
                options: {
                    sourceMap: false,
                    output: { beautify: true },
                    mangle: false,
                    compress: false
                },
                src: [
                    'wwwroot/lib/sceditor/sceditor.min.js',
                    'wwwroot/lib/sceditor/formats/bbcode.js',
                    'wwwroot/lib/sceditor/icons/fontawesome.js',
                    'wwwroot/lib/sceditor/plugins/dragdrop.js',
                    'wwwroot/lib/sceditor/plugins/undo.js',
                    'wwwroot/lib/sceditor/mentions.js'
                ],
                dest: 'wwwroot/js/sceditor/sceditor.min.js'
            },
            forumExtensions: {
                options: {
                    sourceMap: false,
                    output: { beautify: true },
                    mangle: false,
                    compress: false
                },
                src: [
                    'wwwroot/lib/bootstrap.bundle.js',
                    'wwwroot/lib/bootbox.js',
                    'wwwroot/lib/dark-editable.js',
                    'wwwroot/lib/bootstrap-notify.js',
                    'wwwroot/lib/forum/bootstrap-touchspin.js',
                    'wwwroot/lib/choices/assets/scripts/choices.js',
                    'wwwroot/lib/bs5-lightbox/dist/index.bundle.min.js',
                    'wwwroot/lib/forum/hoverCard.js',
                    'wwwroot/lib/prism.js',
                    'node_modules/long-press-event/src/long-press-event.js',
                    'node_modules/@microsoft/signalr/dist/browser/signalr.js',
                    'wwwroot/lib/forum/utilities.js',
                    'wwwroot/lib/forum/albums.js',
                    'wwwroot/lib/forum/attachments.js',
                    'wwwroot/lib/forum/notify.js',
                    'wwwroot/lib/forum/searchResults.js',
                    'wwwroot/lib/forum/similarTitles.js',
                    'wwwroot/lib/forum/paging.js',
                    'wwwroot/lib/forum/main.js',
                    'wwwroot/lib/forum/modals.js',
                    'wwwroot/lib/forum/signalR.js',
                    'wwwroot/lib/forum/contextMenu.js',
                    'wwwroot/lib/forum/chatHub.js',
                    'wwwroot/lib/form-serialize/index.js'
                ],
                dest: 'wwwroot/js/forumExtensions.js'
            },
            forumAdminExtensions: {
                options: {
                    sourceMap: false,
                    output: { beautify: true },
                    mangle: false,
                    compress: false
                },
                src: [
                    'wwwroot/lib/bootstrap.bundle.js',
                    'wwwroot/lib/bootbox.js',
                    'wwwroot/lib/dark-editable.js',
                    'wwwroot/lib/bootstrap-notify.js',
                    'wwwroot/lib/forum/bootstrap-touchspin.js',
                    'wwwroot/lib/choices/assets/scripts/choices.js',
                    'wwwroot/lib/bs5-lightbox/dist/index.bundle.min.js',
                    'wwwroot/lib/forum/hoverCard.js',
                    'wwwroot/lib/prism.js',
                    'node_modules/long-press-event/src/long-press-event.js',
                    'node_modules/@microsoft/signalr/dist/browser/signalr.js',
                    'wwwroot/lib/forum/utilities.js',
                    'wwwroot/lib/forum/albums.js',
                    'wwwroot/lib/forum/notify.js',
                    'wwwroot/lib/forum/paging.js',
                    'wwwroot/lib/forum/main.js',
                    'wwwroot/lib/forum/modals.js',
                    'wwwroot/lib/forum/notificationHub.js',
                    'wwwroot/lib/forum/contextMenu.js',
                    'wwwroot/lib/form-serialize/index.js'
                ],
                dest: 'wwwroot/js/forumAdminExtensions.js'
            },
            minify: {
                files: {
                    "wwwroot/js/editor.min.js": 'wwwroot/js/editor.comb.js',
                    "wwwroot/js/InstallWizard.comb.min.js": 'wwwroot/js/InstallWizard.comb.js',
                    "wwwroot/js/codemirror.min.js": 'wwwroot/js/codemirror.min.js',
                    "wwwroot/js/fileUploader.min.js": 'wwwroot/lib/fileUploader.js',
                    "wwwroot/js/forumExtensions.min.js": 'wwwroot/js/forumExtensions.js',
                    "wwwroot/js/forumAdminExtensions.min.js": 'wwwroot/js/forumAdminExtensions.js'

                }
            }
        },

        sass: {
            installWizard: {
                files: {
                    "wwwroot/css/InstallWizard.css": 'wwwroot/lib/InstallWizard.scss'
                }
            },
            forum: {
                files: {
                    "wwwroot/css/forum.css": 'wwwroot/lib/forum.scss'
                }
            },
            forumAdmin: {
                files: {
                    "wwwroot/css/forum-admin.css": 'wwwroot/lib/forum-admin.scss'
                }
            },
            bootstrap: {
                files: {
                    "wwwroot/lib/bootstrap/bootstrap.css": 'wwwroot/lib/bootstrap/bootstrap.scss'
                }
            },
            themes: {
                files: {
                    "wwwroot/css/themes/zephyr/bootstrap-forum.css": 'wwwroot/lib/themes/zephyr/bootstrap-forum.scss',
                    "wwwroot/css/themes/yaf/bootstrap-forum.css": 'wwwroot/lib/themes/yaf/bootstrap-forum.scss',
                    "wwwroot/css/themes/yeti/bootstrap-forum.css": 'wwwroot/lib/themes/yeti/bootstrap-forum.scss',
                    "wwwroot/css/themes/vapor/bootstrap-forum.css": 'wwwroot/lib/themes/vapor/bootstrap-forum.scss',
                    "wwwroot/css/themes/united/bootstrap-forum.css": 'wwwroot/lib/themes/united/bootstrap-forum.scss',
                    "wwwroot/css/themes/superhero/bootstrap-forum.css":
                        'wwwroot/lib/themes/superhero/bootstrap-forum.scss',
                    "wwwroot/css/themes/spacelab/bootstrap-forum.css":
                        'wwwroot/lib/themes/spacelab/bootstrap-forum.scss',
                    "wwwroot/css/themes/solar/bootstrap-forum.css": 'wwwroot/lib/themes/solar/bootstrap-forum.scss',
                    "wwwroot/css/themes/slate/bootstrap-forum.css": 'wwwroot/lib/themes/slate/bootstrap-forum.scss',
                    "wwwroot/css/themes/sketchy/bootstrap-forum.css": 'wwwroot/lib/themes/sketchy/bootstrap-forum.scss',
                    "wwwroot/css/themes/simplex/bootstrap-forum.css": 'wwwroot/lib/themes/simplex/bootstrap-forum.scss',
                    "wwwroot/css/themes/sandstone/bootstrap-forum.css":
                        'wwwroot/lib/themes/sandstone/bootstrap-forum.scss',
                    "wwwroot/css/themes/quartz/bootstrap-forum.css": 'wwwroot/lib/themes/quartz/bootstrap-forum.scss',
                    "wwwroot/css/themes/pulse/bootstrap-forum.css": 'wwwroot/lib/themes/pulse/bootstrap-forum.scss',
                    "wwwroot/css/themes/morph/bootstrap-forum.css": 'wwwroot/lib/themes/morph/bootstrap-forum.scss',
                    "wwwroot/css/themes/minty/bootstrap-forum.css": 'wwwroot/lib/themes/minty/bootstrap-forum.scss',
                    "wwwroot/css/themes/materia/bootstrap-forum.css": 'wwwroot/lib/themes/materia/bootstrap-forum.scss',
                    "wwwroot/css/themes/lux/bootstrap-forum.css": 'wwwroot/lib/themes/lux/bootstrap-forum.scss',
                    "wwwroot/css/themes/lumen/bootstrap-forum.css": 'wwwroot/lib/themes/lumen/bootstrap-forum.scss',
                    "wwwroot/css/themes/litera/bootstrap-forum.css": 'wwwroot/lib/themes/litera/bootstrap-forum.scss',
                    "wwwroot/css/themes/journal/bootstrap-forum.css": 'wwwroot/lib/themes/journal/bootstrap-forum.scss',
                    "wwwroot/css/themes/flatly/bootstrap-forum.css": 'wwwroot/lib/themes/flatly/bootstrap-forum.scss',
                    "wwwroot/css/themes/darkly/bootstrap-forum.css": 'wwwroot/lib/themes/darkly/bootstrap-forum.scss',
                    "wwwroot/css/themes/cyborg/bootstrap-forum.css": 'wwwroot/lib/themes/cyborg/bootstrap-forum.scss',
                    "wwwroot/css/themes/cosmo/bootstrap-forum.css": 'wwwroot/lib/themes/cosmo/bootstrap-forum.scss',
                    "wwwroot/css/themes/cerulean/bootstrap-forum.css":
                        'wwwroot/lib/themes/cerulean/bootstrap-forum.scss'
                }
            }
        },

        postcss: {
            options: {
                map: false,
                processors: [
                    require('autoprefixer')({ overrideBrowserslist: 'last 2 versions' })
                ]
            },
            installWizard: {
                src: 'wwwroot/css/InstallWizard.css'
            },
            forum: {
                src: 'wwwroot/css/forum.css'
            },
            forumAdmin: {
                src: 'wwwroot/css/forum-admin.css'
            },
            themes: {
                src: 'wwwroot/css/themes/**/*.css'
            }
        },

        // CSS Minify
        cssmin: {
            codeMirror: {
                files: {
                    "wwwroot/css/codemirror.min.css": [
                        'node_modules/codemirror/lib/codemirror.css',
                        'node_modules/codemirror/theme/monokai.css',
                        'node_modules/codemirror/addon/hint/show-hint.css'
                    ]
                }
            },
            other: {
                files: {
                    "wwwroot/css/InstallWizard.min.css": 'wwwroot/css/InstallWizard.css',
                    "wwwroot/css/forum.min.css": 'wwwroot/css/forum.css',
                    "wwwroot/css/forum-admin.min.css": 'wwwroot/css/forum-admin.css'
                }
            },
            themes: {
                files: {
                    "wwwroot/css/themes/zephyr/bootstrap-forum.min.css":
                        'wwwroot/css/themes/zephyr/bootstrap-forum.css',
                    "wwwroot/css/themes/yaf/bootstrap-forum.min.css": 'wwwroot/css/themes/yaf/bootstrap-forum.css',
                    "wwwroot/css/themes/yeti/bootstrap-forum.min.css": 'wwwroot/css/themes/yeti/bootstrap-forum.css',
                    "wwwroot/css/themes/vapor/bootstrap-forum.min.css": 'wwwroot/css/themes/vapor/bootstrap-forum.css',
                    "wwwroot/css/themes/united/bootstrap-forum.min.css":
                        'wwwroot/css/themes/united/bootstrap-forum.css',
                    "wwwroot/css/themes/superhero/bootstrap-forum.min.css":
                        'wwwroot/css/themes/superhero/bootstrap-forum.css',
                    "wwwroot/css/themes/spacelab/bootstrap-forum.min.css":
                        'wwwroot/css/themes/spacelab/bootstrap-forum.css',
                    "wwwroot/css/themes/solar/bootstrap-forum.min.css": 'wwwroot/css/themes/solar/bootstrap-forum.css',
                    "wwwroot/css/themes/slate/bootstrap-forum.min.css": 'wwwroot/css/themes/slate/bootstrap-forum.css',
                    "wwwroot/css/themes/sketchy/bootstrap-forum.min.css":
                        'wwwroot/css/themes/sketchy/bootstrap-forum.css',
                    "wwwroot/css/themes/simplex/bootstrap-forum.min.css":
                        'wwwroot/css/themes/simplex/bootstrap-forum.css',
                    "wwwroot/css/themes/sandstone/bootstrap-forum.min.css":
                        'wwwroot/css/themes/sandstone/bootstrap-forum.css',
                    "wwwroot/css/themes/quartz/bootstrap-forum.min.css":
                        'wwwroot/css/themes/quartz/bootstrap-forum.css',
                    "wwwroot/css/themes/pulse/bootstrap-forum.min.css": 'wwwroot/css/themes/pulse/bootstrap-forum.css',
                    "wwwroot/css/themes/morph/bootstrap-forum.min.css": 'wwwroot/css/themes/morph/bootstrap-forum.css',
                    "wwwroot/css/themes/minty/bootstrap-forum.min.css": 'wwwroot/css/themes/minty/bootstrap-forum.css',
                    "wwwroot/css/themes/materia/bootstrap-forum.min.css":
                        'wwwroot/css/themes/materia/bootstrap-forum.css',
                    "wwwroot/css/themes/lux/bootstrap-forum.min.css": 'wwwroot/css/themes/lux/bootstrap-forum.css',
                    "wwwroot/css/themes/lumen/bootstrap-forum.min.css": 'wwwroot/css/themes/lumen/bootstrap-forum.css',
                    "wwwroot/css/themes/litera/bootstrap-forum.min.css":
                        'wwwroot/css/themes/litera/bootstrap-forum.css',
                    "wwwroot/css/themes/journal/bootstrap-forum.min.css":
                        'wwwroot/css/themes/journal/bootstrap-forum.css',
                    "wwwroot/css/themes/flatly/bootstrap-forum.min.css":
                        'wwwroot/css/themes/flatly/bootstrap-forum.css',
                    "wwwroot/css/themes/darkly/bootstrap-forum.min.css":
                        'wwwroot/css/themes/darkly/bootstrap-forum.css',
                    "wwwroot/css/themes/cyborg/bootstrap-forum.min.css":
                        'wwwroot/css/themes/cyborg/bootstrap-forum.css',
                    "wwwroot/css/themes/cosmo/bootstrap-forum.min.css": 'wwwroot/css/themes/cosmo/bootstrap-forum.css',
                    "wwwroot/css/themes/cerulean/bootstrap-forum.min.css":
                        'wwwroot/css/themes/cerulean/bootstrap-forum.css'
                }
            }
        },

        devUpdate: {
            main: {
                options: {
                    reportUpdated: true,
                    updateType: 'force',
                    semver: true,
                    packages: {
                        devDependencies: true,
                        dependencies: true
                    }
                }
            }
        }
    });

    // PLUGINS
    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('@lodder/grunt-postcss');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-cssmin');
    grunt.loadNpmTasks('@w8tcha/grunt-dev-update');
    grunt.loadNpmTasks('grunt-zip');
    grunt.loadNpmTasks('grunt-downloadfile');
    grunt.loadNpmTasks('grunt-shell');
    grunt.loadNpmTasks('grunt-replace');
    grunt.loadNpmTasks('grunt-webpack');

    grunt.registerTask('upgradeYAF',
        [
            'devUpdate', 'downloadfile', 'unzip', 'copy', 'shell', 'replace'
        ]);

    grunt.registerTask('default',
        [
            'devUpdate', 'webpack:lightBox', 'uglify', 'sass', 'postcss', 'cssmin'
        ]);
};
