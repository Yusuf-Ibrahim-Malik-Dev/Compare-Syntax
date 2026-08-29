const fs = require('fs');
const path = require('path');
const https = require('https');
const { execSync } = require('child_process');

// 1. Inisialisasi struktur folder
const dirs = [
  'assets/css',
  'assets/js',
  'assets/css/webfonts'
];
dirs.forEach(dir => fs.mkdirSync(dir, { recursive: true }));

// Fungsi pembantu untuk mengunduh file
function download(url, dest) {
  return new Promise((resolve, reject) => {
    const file = fs.createWriteStream(dest);
    https.get(url, (response) => {
      if (response.statusCode === 302 || response.statusCode === 301) {
        // Handle redirect jika ada
        download(response.headers.location, dest).then(resolve).catch(reject);
        return;
      }
      response.pipe(file);
      file.on('finish', () => {
        file.close();
        console.log(`✓ Unduh berhasil: ${path.basename(dest)}`);
        resolve();
      });
    }).on('error', (err) => {
      fs.unlink(dest, () => {});
      reject(err);
    });
  });
}

async function init() {
  console.log('📦 Memulai persiapan aset offline...');

  // 2. Daftar file CDN reguler yang akan diunduh
  const assets = [
    { url: 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css', dest: 'assets/css/all.min.css' },
    { url: 'https://cdnjs.cloudflare.com/ajax/libs/js-beautify/1.14.7/beautify.min.js', dest: 'assets/js/beautify.min.js' },
    { url: 'https://cdnjs.cloudflare.com/ajax/libs/js-beautify/1.14.7/beautify-css.min.js', dest: 'assets/js/beautify-css.min.js' },
    { url: 'https://cdnjs.cloudflare.com/ajax/libs/js-beautify/1.14.7/beautify-html.min.js', dest: 'assets/js/beautify-html.min.js' },
    { url: 'https://cdn.jsdelivr.net/npm/diff@5.2.0/dist/diff.min.js', dest: 'assets/js/diff.min.js' },
    { url: 'https://cdn.jsdelivr.net/npm/diff-match-patch@1.0.5/index.js', dest: 'assets/js/index.js' },
    { url: 'https://cdn.jsdelivr.net/npm/diff2html@3.4.48/bundles/css/diff2html.min.css', dest: 'assets/css/diff2html.min.css' },
    { url: 'https://cdn.jsdelivr.net/npm/diff2html@3.4.48/bundles/js/diff2html.min.js', dest: 'assets/js/diff2html.min.js' },
    { url: 'https://cdn.jsdelivr.net/npm/jsondiffpatch@0.6.0/dist/jsondiffpatch.umd.js', dest: 'assets/js/jsondiffpatch.umd.js' },
    { url: 'https://cdn.jsdelivr.net/npm/jsondiffpatch@0.6.0/dist/formatters-styles/html.css', dest: 'assets/css/html.css' }
  ];

  // Font Awesome membutuhkan file font agar ikon tidak kotak-kotak kosong
  const faFonts = ['fa-solid-900.woff2', 'fa-regular-400.woff2', 'fa-brands-400.woff2'];
  faFonts.forEach(font => {
    assets.push({
      url: `https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/webfonts/${font}`,
      dest: `assets/css/webfonts/${font}`
    });
  });

  for (const asset of assets) {
    try {
      await download(asset.url, asset.dest);
    } catch (err) {
      console.error(`✗ Gagal mengunduh ${asset.url}:`, err.message);
    }
  }

  // 3. Mengunduh Paket Monaco Editor secara utuh via NPM
  console.log('\n🤖 Mengunduh paket Monaco Editor (butuh beberapa saat)...');
  try {
    execSync('npm init -y', { stdio: 'ignore' });
    execSync('npm install monaco-editor@0.39.0', { stdio: 'inherit' });
    
    // Pindahkan isi folder min editor ke assets/js/monaco
    const sourceFolder = path.join(__dirname, 'node_modules', 'monaco-editor', 'min');
    const destFolder = path.join(__dirname, 'assets', 'js', 'monaco');
    
    fs.mkdirSync(destFolder, { recursive: true });
    
    // Fungsi rekursif untuk menyalin folder monaco
    const copyRecursive = (src, dest) => {
      fs.mkdirSync(dest, { recursive: true });
      fs.readdirSync(src).forEach(child => {
        const srcPath = path.join(src, child);
        const destPath = path.join(dest, child);
        if (fs.lstatSync(srcPath).isDirectory()) {
          copyRecursive(srcPath, destPath);
        } else {
          fs.copyFileSync(srcPath, destPath);
        }
      });
    };
    
    copyRecursive(sourceFolder, destFolder);
    console.log('✓ Paket Monaco Editor berhasil dipindahkan ke lokal.');
    
    // Bersihkan node_modules sisa instalasi agar proyek tetap ringan
    fs.rmSync(path.join(__dirname, 'node_modules'), { recursive: true, force: true });
    fs.rmSync(path.join(__dirname, 'package.json'), { force: true });
    fs.rmSync(path.join(__dirname, 'package-lock.json'), { force: true });

    console.log('\n🎉 Selesai! Semua aset siap dan aplikasi Anda kini 100% Offline.');
  } catch (err) {
    console.error('✗ Gagal memproses paket Monaco Editor:', err.message);
  }
}

init();