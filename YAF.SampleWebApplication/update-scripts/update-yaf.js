#!/usr/bin/env node
/**
 * Downloads the latest YAF.NET SqlServer upgrade package (matching the
 * version in package.json) and installs it into bin/ and Forum/.
 *
 * Replaces the old Gruntfile.js default task (downloadfile, unzip, copy, shell).
 */
'use strict';

const fs = require('node:fs');
const path = require('node:path');
const { execFileSync } = require('node:child_process');

const root = path.join(__dirname, '..');
const pkg = JSON.parse(fs.readFileSync(path.join(root, 'package.json'), 'utf8'));
const version = pkg.version;

const zipName = 'YAF.SqlServer-Upgrade.zip';
const zipUrl = `https://github.com/YAFNET/YAFNET/releases/download/v${version}/YAF.SqlServer-v${version}-Upgrade.zip`;
const zipPath = path.join(root, zipName);
const upgradeDir = path.join(root, 'upgrade');

const isDll = (srcPath) => fs.statSync(srcPath).isDirectory() || srcPath.toLowerCase().endsWith('.dll');

const COPY_MAP = [
    { src: 'bin', dest: path.join(root, 'bin'), filter: isDll },
    { src: 'Content', dest: path.join(root, 'Forum', 'Content') },
    { src: 'Controls', dest: path.join(root, 'Forum', 'controls') },
    { src: 'Dialogs', dest: path.join(root, 'Forum', 'Dialogs') },
    { src: 'Images', dest: path.join(root, 'Forum', 'Images') },
    { src: 'Install', dest: path.join(root, 'Forum', 'install') },
    { src: 'languages', dest: path.join(root, 'Forum', 'languages') },
    { src: 'Pages', dest: path.join(root, 'Forum', 'pages') },
    { src: 'Resources', dest: path.join(root, 'Forum', 'Resources') },
    { src: 'Scripts', dest: path.join(root, 'Forum', 'Scripts') },
];

async function download(url, dest) {
    console.log(`Downloading ${url}`);
    const res = await fetch(url, { redirect: 'follow' });
    if (!res.ok) {
        throw new Error(`Download failed: ${res.status} ${res.statusText}`);
    }
    fs.writeFileSync(dest, Buffer.from(await res.arrayBuffer()));
}

function unzip(zipFile, destDir) {
    console.log(`Extracting ${zipFile} -> ${destDir}`);
    execFileSync('powershell.exe', [
        '-NoProfile', '-NonInteractive', '-Command',
        `Expand-Archive -LiteralPath '${zipFile}' -DestinationPath '${destDir}' -Force`,
    ], { stdio: 'inherit' });
}

function copyDir({ src, dest, filter }) {
    const srcPath = path.join(upgradeDir, src);
    if (!fs.existsSync(srcPath)) {
        return;
    }
    fs.mkdirSync(dest, { recursive: true });
    fs.cpSync(srcPath, dest, { recursive: true, force: true, filter });
}

async function main() {
    await download(zipUrl, zipPath);
    unzip(zipPath, upgradeDir);

    for (const entry of COPY_MAP) {
        copyDir(entry);
    }

    const errorAspx = path.join(upgradeDir, 'error.aspx');
    if (fs.existsSync(errorAspx)) {
        fs.copyFileSync(errorAspx, path.join(root, 'Forum', 'error.aspx'));
    }

    fs.rmSync(upgradeDir, { recursive: true, force: true });
    fs.rmSync(zipPath, { force: true });

    console.log(`YAF.NET updated to v${version}.`);
}

main().catch((err) => {
    console.error(err);
    process.exit(1);
});
