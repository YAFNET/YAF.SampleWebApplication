#!/usr/bin/env node
/**
 * Copies the minified script files over the unminified names, so the
 * non-minified <script> references in the pages resolve during debugging.
 *
 * Replaces the old Gruntfile.js shell:copyDebug task.
 */
'use strict';

const fs = require('node:fs');
const path = require('node:path');

const scriptsDir = path.join(__dirname, '..', 'Forum', 'Scripts');

const pairs = [
    ['forumAdminExtensions.min.js', 'forumAdminExtensions.js'],
    ['forumExtensions.min.js', 'forumExtensions.js']
];

for (const [src, dest] of pairs) {
    fs.copyFileSync(path.join(scriptsDir, src), path.join(scriptsDir, dest));
    console.log(`${src} -> ${dest}`);
}
