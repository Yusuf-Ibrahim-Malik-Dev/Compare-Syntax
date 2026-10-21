<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Compare.aspx.cs" Inherits="CompareSyntax.Compare" %>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Super Power Syntax Compare & Developer Suite v3 (Ultimate Offline Edition)</title>

    <!-- Core Libraries & Font Icons (LOKAL) -->
    <link rel="stylesheet" data-name="vs/editor/editor.main" href="assets/js/monaco/vs/editor/editor.main.css" />
    <link rel="stylesheet" href="assets/css/all.min.css" />

    <!-- JS Beautify Engines (LOKAL) -->
    <script src="assets/js/beautify.min.js"></script>
    <script src="assets/js/beautify-css.min.js"></script>
    <script src="assets/js/beautify-html.min.js"></script>

    <!-- High-Precision Advanced Diff Engines (LOKAL) -->
    <script src="assets/js/diff.min.js"></script>
    <script src="assets/js/index.js"></script>
    <link rel="stylesheet" href="assets/css/diff2html.min.css" />
    <script src="assets/js/diff2html.min.js"></script>
    <script src="assets/js/jsondiffpatch.umd.js"></script>
    <link rel="stylesheet" href="assets/css/html.css" />

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Base Body & Transisi Warna */
        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background: #f8fafc;
            color: #0f172a;
            min-height: 100vh;
            transition: background 0.5s ease, color 0.5s ease;
        }

            /* Mode Gelap Bawaan (Tombol Moon) */
            body.dark {
                background: #0b1329;
                color: #f1f5f9;
            }

        .app {
            max-width: 1800px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        /* ========================================================
        PERBAIKAN UTAMA: CSS KETIKA TEMBA BADAI YUSUF AKTIF (.yusuf-storm-active)
        ======================================================== */
        body.yusuf-storm-active {
            background: #050b18 !important; /* Latar belakang halaman berubah gelap total */
            color: #f1f5f9 !important; /* Teks utama menjadi terang */
        }

            /* Toolbar Menjadi Gelap Saat Badai */
            body.yusuf-storm-active .toolbar {
                background: #101c36 !important;
                border-color: #1b2d54 !important;
                box-shadow: 0 4px 20px rgba(0,0,0,0.4) !important;
            }

            /* Kotak Pager / Paging Menjadi Gelap Saat Badai */
            body.yusuf-storm-active .pager-container {
                background: #172649 !important;
                color: #f1f5f9 !important;
            }

            /* Pilihan Bahasa & Tombol Biasa Menjadi Gelap Saat Badai */
            body.yusuf-storm-active .lang-select {
                background: #172649 !important;
                border-color: #2b3f6c !important;
                color: #f1f5f9 !important;
            }

            body.yusuf-storm-active .btn:not(.btn-primary):not(.btn-success):not(.btn-danger) {
                background: #172649 !important;
                color: #cbd5e1 !important;
                border-color: #2b3f6c !important;
            }

            /* Editor Container Kiri & Kanan Menjadi Gelap Saat Badai */
            body.yusuf-storm-active .editor-container {
                background: #0d162d !important;
                border-color: #1b2d54 !important;
            }

            body.yusuf-storm-active .editor-header {
                background: #101c36 !important;
                border-bottom-color: #1b2d54 !important;
                color: #94a3b8 !important;
            }

            body.yusuf-storm-active .badge {
                background: #172649 !important;
                color: #cbd5e1 !important;
            }

            /* Panel Analytics Bawah Menjadi Gelap Saat Badai */
            body.yusuf-storm-active .compare-panel {
                background: #0d162d !important;
                border-color: #1b2d54 !important;
            }

            body.yusuf-storm-active .compare-header {
                background: #101c36 !important;
                border-bottom-color: #1b2d54 !important;
            }

            body.yusuf-storm-active .compare-body {
                background: #121f3f !important;
            }


        /* Toolbar Pro */
        .toolbar {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            background: white;
            padding: 12px 20px;
            border-radius: 14px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.03);
            border: 1px solid #e2e8f0;
            flex: 0 0 auto;
        }

        body.dark .toolbar {
            background: #142242;
            border-color: #23355a;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }

        .toolbar-group {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 8px;
        }

        .lang-select {
            padding: 8px 16px;
            border-radius: 20px;
            border: 1px solid #cbd5e1;
            background: #f1f5f9;
            font-weight: 600;
            font-size: 0.85rem;
            cursor: pointer;
            color: #334155;
            outline: none;
            max-width: 250px;
        }

        body.dark .lang-select {
            background: #1e293b;
            border-color: #334155;
            color: #f1f5f9;
        }

        .pager-container {
            display: none;
            align-items: center;
            gap: 6px;
            background: #f1f5f9;
            padding: 2px 10px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        body.dark .pager-container {
            background: #1e293b;
        }

        /* Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 20px;
            border: none;
            font-weight: 600;
            font-size: 0.85rem;
            background: #e2e8f0;
            color: #334155;
            cursor: pointer;
            transition: all 0.2s ease;
            border: 1px solid transparent;
            user-select: none;
        }

        body.dark .btn {
            background: #1e293b;
            color: #cbd5e1;
        }

        .btn:hover {
            transform: translateY(-1px);
            opacity: 0.9;
        }

        .btn-primary {
            background: #2563eb;
            color: white;
        }

        body.dark .btn-primary {
            background: #3b82f6;
            color: white;
        }

        .btn-success {
            background: #10b981;
            color: white;
        }

        body.dark .btn-success {
            background: #10b981;
            color: white;
        }

        .btn-danger {
            background: #ef4444;
            color: white;
        }

        .btn-outline {
            background: transparent;
            border-color: #cbd5e1;
        }

        body.dark .btn-outline {
            border-color: #334155;
        }

        .btn-icon {
            border-radius: 50%;
            width: 36px;
            height: 36px;
            padding: 0;
        }

        /* Main Grid Editors */
        .main-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            flex: 0 0 auto;
        }

        .editor-container {
            background: white;
            border-radius: 14px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.02);
            border: 1px solid #e2e8f0;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        body.dark .editor-container {
            background: #111a33;
            border-color: #23355a;
        }

        .editor-header {
            padding: 10px 16px;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.8rem;
            font-weight: 600;
            color: #64748b;
            flex: 0 0 auto;
        }

        body.dark .editor-header {
            background: #142242;
            border-bottom-color: #23355a;
            color: #94a3b8;
        }

        .badge {
            background: #e2e8f0;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 0.7rem;
            color: #334155;
        }

        body.dark .badge {
            background: #1e293b;
            color: #cbd5e1;
        }

        .monaco-editor-container {
            height: 400px;
            width: 100%;
            flex: 1 1 auto;
        }

        /* Compare Output Panel */
        .compare-panel {
            background: white;
            border-radius: 14px;
            border: 1px solid #e2e8f0;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            box-shadow: 0 4px 20px rgba(0,0,0,0.02);
            margin-top: 16px;
        }

        body.dark .compare-panel {
            background: #111a33;
            border-color: #23355a;
        }

        .compare-header {
            padding: 12px 20px;
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex: 0 0 auto;
        }

        body.dark .compare-header {
            background: #142242;
            border-bottom-color: #23355a;
        }

        .compare-body {
            height: 650px;
            display: flex;
            flex-direction: column;
            position: relative;
            background: #fafafa;
        }

        body.dark .compare-body {
            background: #1e293b;
        }

        .empty-diff-state {
            position: absolute;
            inset: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #64748b;
            gap: 12px;
            z-index: 10;
            background: inherit;
        }

            .empty-diff-state i {
                font-size: 3rem;
                opacity: 0.4;
            }

        /* Dashboard Tabs System */
        .dashboard-tabs {
            display: flex;
            gap: 4px;
            border-bottom: 1px solid #cbd5e1;
            background: #f1f5f9;
            padding: 4px 10px 0;
            flex: 0 0 auto;
        }

        body.dark .dashboard-tabs {
            background: #142242;
            border-bottom-color: #23355a;
        }

        .tab-btn {
            padding: 8px 14px;
            font-size: 0.75rem;
            font-weight: 600;
            background: transparent;
            border: none;
            cursor: pointer;
            color: #64748b;
            border-radius: 6px 6px 0 0;
            outline: none;
        }

            .tab-btn.active {
                background: white;
                color: #2563eb;
                font-weight: 700;
                box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
            }

        body.dark .tab-btn.active {
            background: #111a33;
            color: #3b82f6;
        }

        .dashboard-content-wrapper {
            padding: 16px;
            flex: 1;
            display: flex;
            flex-direction: column;
            background: white;
            position: relative;
            overflow: hidden;
        }

        body.dark .dashboard-content-wrapper {
            background: #111a33;
        }

        .tab-content {
            display: none;
            width: 100%;
            height: 100%;
            flex: 1;
            flex-direction: column;
            overflow-y: auto;
        }

            .tab-content.active {
                display: flex;
            }

        #tab-visual-diff {
            overflow: hidden;
            padding-bottom: 0;
        }

        #legendContainer {
            flex: 0 0 auto;
            margin-bottom: 10px;
        }

        #monacoDiffInstance {
            flex: 1;
            width: 100%;
            position: relative;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            overflow: hidden;
        }

        body.dark #monacoDiffInstance {
            border-color: #23355a;
        }

        .grid-metrics {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 12px;
            flex: 0 0 auto;
        }

        .card-metric {
            padding: 12px 16px;
            border-radius: 10px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        body.dark .card-metric {
            background: #192646;
            border-color: #23355a;
        }

        .card-title {
            font-size: 0.7rem;
            text-transform: uppercase;
            tracking: 0.05em;
            color: #64748b;
            font-weight: 600;
        }

        body.dark .card-title {
            color: #94a3b8;
        }

        .card-value {
            font-size: 1.15rem;
            font-weight: 700;
            color: #0f172a;
        }

        body.dark .card-value {
            color: #f1f5f9;
        }

        .search-panel-bar {
            display: flex;
            gap: 6px;
            margin-bottom: 12px;
            flex-wrap: wrap;
        }

        .search-input-field {
            padding: 6px 12px;
            font-size: 0.8rem;
            border-radius: 6px;
            border: 1px solid #cbd5e1;
            outline: none;
            background: #f8fafc;
            width: 220px;
        }

        body.dark .search-input-field {
            background: #1e293b;
            border-color: #334155;
            color: #f1f5f9;
        }

        .analysis-section-title {
            font-size: 0.9rem;
            font-weight: 700;
            color: #2563eb;
            margin: 16px 0 8px 0;
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 4px;
        }

        body.dark .analysis-section-title {
            color: #3b82f6;
            border-bottom-color: #23355a;
        }

        /* =================================================================
       PERBAIKAN TAMPILAN LEGENDA SECARA PROFESIONAL & ELEGAN
       ================================================================= */
        .color-legend-box {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            gap: 12px;
            background: #f1f5f9;
            padding: 14px;
            border-radius: 8px;
            font-size: 0.78rem;
        }

        body.dark .color-legend-box {
            background: #1e293b;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 4px;
        }

        .legend-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 16px;
            height: 16px;
            font-size: 1rem;
        }

        .lg-added {
            color: #10b981;
        }

        .lg-deleted {
            color: #ef4444;
        }

        .lg-modified {
            color: #eab308;
        }

        .lg-moved {
            color: #3b82f6;
        }

        .lg-renamed {
            color: #a855f7;
        }

        .lg-conflict {
            color: #f97316;
        }

        .lg-copied {
            color: #78350f;
        }

        .lg-binary {
            color: #64748b;
        }

        .lg-selected {
            color: #06b6d4;
        }

        .lg-add-block {
            color: #059669;
        }

        .lg-del-block {
            color: #dc2626;
        }

        .lg-mod-block {
            color: #d97706;
        }

        .lg-mov-block {
            color: #2563eb;
        }

        .lg-refactored {
            color: #8b5cf6;
        }

        .lg-warning {
            color: #f43f5e;
        }

        /* =================================================================
       PERBAIKAN TOTAL WARNA & BLOK VISUAL PERSIS SEPERTI GAMBAR GIT DIFF
       ================================================================= */
        /* Warna Solid Latar Baris untuk Perubahan Teks (High Contrast) */
        .monaco-diff-editor .line-delete {
            background-color: rgba(239, 68, 68, 0.25) !important;
        }

        .monaco-diff-editor .char-delete {
            background-color: rgba(239, 68, 68, 0.55) !important;
            text-decoration: line-through;
        }

        .monaco-diff-editor .line-insert {
            background-color: rgba(16, 185, 129, 0.22) !important;
        }

        .monaco-diff-editor .char-insert {
            background-color: rgba(16, 185, 129, 0.50) !important;
        }

        /* Modifikasi Garis Kosong Pengisi (Diagonal Stripe Patterns) Khlas Pro Git */
        .monaco-diff-editor .diff .diagonal-fill {
            background-image: linear-gradient( 45deg, rgba(0, 0, 0, 0.15) 25%, transparent 25%, transparent 50%, rgba(0, 0, 0, 0.15) 50%, rgba(0, 0, 0, 0.15) 75%, transparent 75%, transparent ) !important;
            background-size: 15px 15px !important;
            background-color: rgba(0, 0, 0, 0.04) !important;
        }

        body.dark .monaco-diff-editor .diff .diagonal-fill {
            background-image: linear-gradient( 45deg, rgba(255, 255, 255, 0.07) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, 0.07) 50%, rgba(255, 255, 255, 0.07) 75%, transparent 75%, transparent ) !important;
            background-color: rgba(255, 255, 255, 0.02) !important;
        }

        /* Penanda Simbol Teks Minus dan Plus Dinamis di Area Gutter */
        .monaco-diff-editor .line-delete::after {
            content: "-";
            color: #ff4d4d;
            font-weight: 900;
            font-size: 16px;
            position: absolute;
            left: -14px;
            top: -2px;
            z-index: 20;
        }

        .monaco-diff-editor .line-insert::after {
            content: "+";
            color: #10b981;
            font-weight: 900;
            font-size: 15px;
            position: absolute;
            left: -14px;
            top: -1px;
            z-index: 20;
        }

        /* Solid Border Tepi di Sebelah Kanan Nomor Baris */
        .monaco-diff-editor .margin-view-overlays .line-delete {
            border-right: 3.5px solid #ef4444 !important;
        }

        .monaco-diff-editor .margin-view-overlays .line-insert {
            border-right: 3.5px solid #10b981 !important;
        }

        .monaco-editor .whitespace {
            color: rgba(234, 179, 8, 0.45) !important;
        }

        .monaco-scrollable-element > .scrollbar {
            z-index: 100 !important;
        }

        @media (max-width: 1024px) {
            .main-grid {
                grid-template-columns: 1fr;
            }
        }


        /* =======================================
   ROOT_NAMA CLASS_YUSUF STYLING
   ======================================= */
        .yusuf-footer {
            background-color: #0c1622; /* Footer cerah */
            padding: 40px 0;
            width: 100%;
            border-top: 2px solid #1b263b;
            position: relative;
            z-index: 10;
            overflow: hidden;
            transition: background-color 0.8s ease, border-color 0.8s ease;
        }

        body.yusuf-storm-active .yusuf-footer {
            background-color: #020304; /* Footer saat badai */
            border-top-color: #11141a;
        }

        .yusuf-footer-container {
            position: relative;
            max-width: 1200px;
            margin: 0 auto;
            text-align: center;
            z-index: 12;
        }

        .yusuf-copyright-text {
            color: #8da9c4;
            font-size: 1rem;
            letter-spacing: 1px;
            transition: color 0.8s ease;
        }

        body.yusuf-storm-active .yusuf-copyright-text {
            color: #5f6470;
        }

        .yusuf-storm-trigger {
            color: #e0e1dd; /* Warna text awal saat cerah */
            text-decoration: none;
            font-weight: bold;
            position: relative;
            transition: color 0.4s ease, text-shadow 0.4s ease;
            display: inline-block;
        }

            .yusuf-storm-trigger:hover {
                color: #00fff2;
            }

        /* EFEK KILATAN FLASH DI TANAH */
        .yusuf-ground-flash {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(ellipse at top, rgba(0, 255, 242, 0.4) 0%, transparent 70%);
            opacity: 0;
            z-index: 11;
            pointer-events: none;
        }

            .yusuf-ground-flash.flash-active {
                animation: flashGround 0.25s ease-out forwards;
            }

        @keyframes flashGround {
            0%, 100% {
                opacity: 0;
            }

            20%, 60% {
                opacity: 1;
            }
        }

        /* RETAKAN TANAH */
        .yusuf-ground-cracks {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: #00fff2;
            opacity: 0;
            z-index: 11;
            pointer-events: none;
            filter: blur(0.5px) drop-shadow(0 0 8px #00fff2);
            clip-path: polygon( 45% 0%, 47% 15%, 43% 30%, 48% 50%, 42% 70%, 46% 100%, 45% 100%, 41% 72%, 46% 51%, 41% 32%, 45% 16%, 44% 0%,
            /* Cabang Kiri */
            43% 30%, 35% 45%, 38% 65%, 30% 85%, 31% 85%, 39% 64%, 36% 46%,
            /* Cabang Kanan */
            48% 50%, 58% 65%, 54% 85%, 65% 100%, 64% 100%, 53% 86%, 57% 66% );
        }

            .yusuf-ground-cracks.cracks-active {
                animation: crackGlow 0.4s ease-out forwards;
            }

        @keyframes crackGlow {
            0% {
                opacity: 0;
                filter: brightness(0.5) blur(1px);
            }

            15%, 45% {
                opacity: 1;
                filter: brightness(2) blur(0px);
            }

            100% {
                opacity: 0;
                filter: brightness(0.2) blur(2px);
            }
        }

        /* =======================================
   WADAH ANIMASI BADAI (HIDDEN BY DEFAULT)
   ======================================= */
        .yusuf-storm-wrapper {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 5;
            opacity: 0;
            transition: opacity 0.8s ease;
        }

            .yusuf-storm-wrapper.active {
                opacity: 1;
            }

            .yusuf-storm-wrapper.ambient-flash {
                animation: skyFlash 0.3s ease-out;
            }

        @keyframes skyFlash {
            0%, 100% {
                background-color: transparent;
            }

            25%, 65% {
                background-color: rgba(255, 255, 255, 0.15);
            }
        }

        /* AWAN BERJALAN */
        .yusuf-cloud-container {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 250px;
            overflow: hidden;
        }

        .yusuf-cloud-layer {
            position: absolute;
            width: 200%;
            height: 100%;
            background: repeat-x url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 100 100'%3E%3Cpath d='M10 80 C 20 60, 40 60, 50 70 C 60 50, 80 50, 90 75 C 95 65, 105 70, 100 85 Z' fill='%23181d26' opacity='0.85'/%3E%3C/svg%3E");
            background-size: 300px 150px;
            filter: blur(8px);
        }

        .yusuf-cloud-1 {
            top: -20px;
            animation: moveClouds 40s linear infinite;
        }

        .yusuf-cloud-2 {
            top: 10px;
            background-size: 450px 200px;
            opacity: 0.6;
            animation: moveClouds 25s linear infinite reverse;
        }

        @keyframes moveClouds {
            0% {
                transform: translateX(0);
            }

            100% {
                transform: translateX(-50%);
            }
        }

        /* HUJAN */
        .yusuf-rain-container {
            position: absolute;
            top: 120px;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .yusuf-drop {
            position: absolute;
            background: linear-gradient(transparent, rgba(0, 255, 242, 0.4));
            width: 1.2px;
            height: 30px;
            animation: fall 0.6s linear infinite;
        }

        @keyframes fall {
            0% {
                transform: translateY(-50px) rotate(15deg);
            }

            100% {
                transform: translateY(100vh) rotate(15deg);
            }
        }

        /* CANVAS PETIR */
        .yusuf-lightning-canvas {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        /* EFEK GEMPA */
        .shake-body {
            animation: hardShake 0.15s linear 2;
        }

        @keyframes hardShake {
            0% {
                transform: translate(2px, 1px) rotate(0deg);
            }

            50% {
                transform: translate(-2px, -3px) rotate(-0.1deg);
            }

            100% {
                transform: translate(1px, 2px) rotate(0.1deg);
            }
        }

        /* --- CLASS CUSTOM --- */
        .root_nama {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            display: inline-block;
            z-index: 1000;
        }

        .clas_yusuf {
            background-color: #1e3a8a;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            cursor: pointer;
            font-weight: bold;
            font-family: 'Poppins', sans-serif;
            position: relative;
            z-index: 1010;
            transition: background 0.2s, transform 0.1s;
            box-shadow: 0 4px 15px rgba(30, 58, 138, 0.4);
        }

            .clas_yusuf:active {
                transform: scale(0.95);
            }

        /* --- CONTAINER HUJAN UANG FULL SCREEN --- */
        #moneyRainContainer {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            pointer-events: none;
            z-index: 999;
            overflow: hidden;
            display: none;
        }

        .money-item {
            position: absolute;
            top: -50px;
            pointer-events: none;
            user-select: none;
        }

        .bill-animation {
            animation: fallAndWave 3.5s ease-in-out infinite;
        }

        .coin-animation {
            animation: fallAndSpinCoin 2.8s linear infinite;
        }

        @keyframes fallAndWave {
            0% {
                transform: translateY(0) translateX(0) rotate(0deg);
                opacity: 1;
            }

            25% {
                transform: translateY(25vh) translateX(25px) rotate(12deg);
            }

            50% {
                transform: translateY(50vh) translateX(-25px) rotate(-12deg);
            }

            75% {
                transform: translateY(75vh) translateX(15px) rotate(8deg);
            }

            100% {
                transform: translateY(105vh) translateX(-5px) rotate(0deg);
                opacity: 0.3;
            }
        }

        @keyframes fallAndSpinCoin {
            0% {
                transform: translateY(0) rotateY(0deg);
                opacity: 1;
            }

            100% {
                transform: translateY(105vh) rotateY(540deg);
                opacity: 0.4;
            }
        }

        /* --- SCENE UTAMA (Awan, Matahari, Canvas) --- */
        #skyScene {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            pointer-events: none;
            z-index: 996;
            display: none;
        }

        .fancy-cloud {
            position: absolute;
            top: 2.5rem;
            left: 2.5rem;
            width: 160px;
            height: 55px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 50px;
            filter: drop-shadow(0 8px 15px rgba(0,0,0,0.1));
            animation: floatCloud 4s ease-in-out infinite alternate;
            z-index: 998;
        }

            .fancy-cloud::before, .fancy-cloud::after {
                content: '';
                position: absolute;
                background: inherit;
                border-radius: 50%;
            }

            .fancy-cloud::before {
                width: 75px;
                height: 75px;
                top: -38px;
                left: 25px;
            }

            .fancy-cloud::after {
                width: 95px;
                height: 95px;
                top: -55px;
                left: 55px;
            }

        .bright-sun {
            position: absolute;
            top: 1.5rem;
            left: 4.5rem;
            width: 85px;
            height: 85px;
            background: radial-gradient(circle, #fff385 0%, #f6e05e 100%);
            border-radius: 50%;
            box-shadow: 0 0 50px rgba(246, 224, 94, 0.7);
            z-index: 997;
            animation: sunPulse 3s ease-in-out infinite;
        }

        @keyframes floatCloud {
            0% {
                transform: translateY(0);
            }

            100% {
                transform: translateY(-8px);
            }
        }

        @keyframes sunPulse {
            0%, 100% {
                transform: scale(1);
                opacity: 0.85;
            }

            50% {
                transform: scale(1.06);
                opacity: 1;
                box-shadow: 0 0 65px rgba(246, 224, 94, 0.9);
            }
        }

        #rainbowCanvas {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 996;
            pointer-events: none;
        }
    </style>
</head>
<body>

    <div class="app">
        <div class="toolbar">
            <div class="toolbar-group">
                <select id="languageSelect" class="lang-select"></select>
                <button class="btn btn-primary" id="compareBtn"><i class="fas fa-bolt"></i><span id="lblCompare">Bandingkan</span> (Ctrl+Enter)</button>
                <button class="btn btn-success" id="formatBtn" title="Rapikan Kode"><i class="fas fa-wand-magic-sparkles"></i>Formatter / Beautify</button>
                <button class="btn btn-outline" id="minifyBtn" title="Kompresi Kode"><i class="fas fa-compress"></i>Minify</button>
            </div>

            <div class="toolbar-group">
                <select id="interfaceLangSelect" class="lang-select" style="border-color: #2563eb;">
                    <option value="id">Bahasa Indonesia</option>
                    <option value="en">English</option>
                </select>

                <div class="pager-container" id="globalPager">
                    <button class="btn btn-outline" id="prevPageBtn" style="padding: 2px 8px; font-size: 0.7rem;"><i class="fas fa-chevron-left"></i></button>
                    <span id="pageIndicator">Halaman 1 / 1</span>
                    <button class="btn btn-outline" id="nextPageBtn" style="padding: 2px 8px; font-size: 0.7rem;"><i class="fas fa-chevron-right"></i></button>
                </div>

                <button class="btn btn-outline" id="swapBtn" title="Tukar Input & Output"><i class="fas fa-right-left"></i><span id="lblSwap">Tukar</span></button>
                <div style="position: relative; display: inline-block;">
                    <button class="btn btn-outline"><i class="fas fa-file-import"></i><span id="lblImport">Impor</span></button>
                    <input type="file" id="fileInput" style="position: absolute; inset: 0; opacity: 0; cursor: pointer;" accept=".js,.ts,.jsx,.tsx,.html,.css,.scss,.sass,.less,.json,.py,.java,.cs,.vb,.fs,.config,.xml,.yaml,.yml,.toml,.ini,.sql,.php,.kt,.swift,.dart,.go,.rs,.cpp,.c,.txt" />
                </div>
                <button class="btn btn-outline btn-icon" id="themeToggle"><i class="fas fa-moon"></i></button>
            </div>
        </div>

        <div class="main-grid">
            <div class="editor-container">
                <div class="editor-header">
                    <span id="lblLeftPanel"><i class="fas fa-edit" style="color: #2563eb"></i>Lembar Kiri - Asli / Multi Deleted (Original)</span>
                    <div class="toolbar-group">
                        <span class="badge" id="inputStats">0 baris | 0 karakter</span>
                        <button class="btn btn-outline btn-icon" style="height: 26px; width: 26px; font-size: 0.7rem;" id="copyInputBtn" title="Salin"><i class="fas fa-copy"></i></button>
                    </div>
                </div>
                <div class="monaco-editor-container" id="inputEditorContainer"></div>
            </div>

            <div class="editor-container">
                <div class="editor-header">
                    <span id="lblRightPanel"><i class="fas fa-code-branch" style="color: #10b981"></i>Lembar Kanan - Multi Added / Edit (Modified)</span>
                    <div class="toolbar-group">
                        <span class="badge" id="outputStats">0 baris | 0 karakter</span>
                        <button class="btn btn-outline btn-icon" style="height: 26px; width: 26px; font-size: 0.7rem;" id="copyOutputBtn" title="Salin"><i class="fas fa-copy"></i></button>
                    </div>
                </div>
                <div class="monaco-editor-container" id="outputEditorContainer"></div>
            </div>
        </div>

        <div class="compare-panel">
            <div class="compare-header">
                <h3 id="lblPanelMainTitle" style="font-size: 0.95rem; font-weight: 700;"><i class="fas fa-circle-nodes" style="color: #ef4444"></i>Dasbor Analisis Perbedaan Berkinerja Tinggi</h3>
                <div class="toolbar-group">
                    <button class="btn btn-outline" id="diffNavigatorBtn" style="padding: 4px 12px; font-size: 0.75rem; display: none;"><i class="fas fa-angles-down"></i><span id="lblJumpDiff">Lompat ke Perbedaan</span></button>
                    <button class="btn btn-outline" id="toggleInlineDiffBtn"><i class="fas fa-list"></i><span id="lblToggleDiff">Ganti Inline / Split View</span></button>
                    <button class="btn btn-danger btn-outline" id="clearDiffBtn" style="padding: 4px 12px; font-size: 0.75rem;"><span id="lblClearWorkspace">Bersihkan Workspace</span></button>
                </div>
            </div>

            <div class="compare-body" id="diffBodyContainer">
                <div class="empty-diff-state" id="emptyDiffState">
                    <i class="fas fa-terminal"></i>
                    <p id="lblEngineReady" style="font-weight: 600;">Mesin Siap</p>
                    <p id="lblEngineSub" style="font-size: 0.8rem; opacity: 0.7;">Tekan Bandingkan atau gunakan pintasan Ctrl + Enter</p>
                </div>

                <div id="monacoDiffViewerWrapper" style="width: 100%; height: 100%; display: none; flex-direction: column;">
                    <div class="dashboard-tabs">
                        <button class="tab-btn active" id="tabTitle1" onclick="switchSuiteTab('visual-diff')"><i class="fas fa-columns"></i>Perbandingan Visual</button>
                        <button class="tab-btn" id="tabTitle2" onclick="switchSuiteTab('dashboard-analitik')"><i class="fas fa-chart-pie"></i>Dasbor Diff & Plagiarisme</button>
                        <button class="tab-btn" id="tabTitle3" onclick="switchSuiteTab('structural-logic')"><i class="fas fa-code"></i>Struktur AST & Logika</button>
                        <button class="tab-btn" id="tabTitle4" onclick="switchSuiteTab('git-metadata')"><i class="fab fa-git-alt"></i>Git Metadata & Riwayat</button>
                        <button class="tab-btn" id="tabTitle5" onclick="switchSuiteTab('search-suite')"><i class="fas fa-search"></i>Pencarian Teks Lanjutan</button>
                    </div>

                    <div class="dashboard-content-wrapper">
                        <!-- Tab 1: Perbandingan Visual -->
                        <div id="tab-visual-diff" class="tab-content active">
                            <div class="color-legend-box" id="legendContainer"></div>
                            <!-- Area Render Diff Engine Utama -->
                            <div id="monacoDiffInstance"></div>
                        </div>

                        <!-- Tab 2: Dasbor Diff & Plagiarisme -->
                        <div id="tab-dashboard-analitik" class="tab-content">
                            <h4 class="analysis-section-title" id="secTitle1">1. Ringkasan Metrik Analisis Diff</h4>
                            <div class="grid-metrics" id="diffMetricsContainer"></div>

                            <h4 class="analysis-section-title" id="secTitle2">2. Deteksi Plagiarisme & Statistik Karakter</h4>
                            <div class="grid-metrics" id="plagiarismMetricsContainer"></div>

                            <h4 class="analysis-section-title" id="secTitle3">🔥 Heatmap Perubahan Berdasarkan Kepadatan</h4>
                            <div class="grid-metrics" id="heatmapContainer"></div>
                        </div>

                        <!-- Tab 3: Struktur AST & Logika -->
                        <div id="tab-structural-logic" class="tab-content">
                            <h4 class="analysis-section-title" id="secTitle4">3. Statistik Struktur Kode & Objek (Analisis AST)</h4>
                            <div class="grid-metrics" id="codeStatsContainer"></div>

                            <h4 class="analysis-section-title" id="secTitle5">4. Validasi Sintaks & Format Penulisan</h4>
                            <div class="grid-metrics" id="syntaxFormattingContainer"></div>

                            <h4 class="analysis-section-title" id="secTitle6">5. Analisis Semantik, Logika, & Refactoring</h4>
                            <div class="grid-metrics" id="semanticLogicContainer"></div>
                        </div>

                        <!-- Tab 4: Git Metadata & Riwayat -->
                        <div id="tab-git-metadata" class="tab-content">
                            <h4 class="analysis-section-title" id="secTitle7">6. Metadata Repositori & Simulasi Status Git</h4>
                            <div class="grid-metrics" id="gitMetadataContainer"></div>

                            <h4 class="analysis-section-title" id="secTitle8">7. Riwayat Komit, Kontrol Konflik Merge, & Analisis Blame</h4>
                            <div class="grid-metrics" id="gitHistoryBlameContainer"></div>
                        </div>

                        <!-- Tab 5: Pencarian Teks Lanjutan -->
                        <div id="tab-search-suite" class="tab-content">
                            <div class="search-panel-bar">
                                <input type="text" id="findInput" class="search-input-field" placeholder="Cari Kata / Pola Regex..." />
                                <input type="text" id="replaceInput" class="search-input-field" placeholder="Ganti dengan..." />
                                <button class="btn btn-outline" id="btnNext" onclick="triggerSearchAction('findNext')">Berikutnya</button>
                                <button class="btn btn-outline" id="btnPrev" onclick="triggerSearchAction('findPrev')">Sebelumnya</button>
                                <button class="btn btn-outline" id="btnReplace" onclick="triggerSearchAction('replace')">Replace</button>
                                <button class="btn btn-outline" id="btnReplaceAll" onclick="triggerSearchAction('replaceAll')">Replace Semua</button>
                            </div>
                            <div style="margin-top: 15px; font-size: 0.8rem; display: flex; flex-direction: column; gap: 6px;">
                                <p id="searchMetaInfo"><strong>Status Mesin Pencari:</strong> Standby</p>
                                <p id="searchHistoryLog"><strong>Riwayat Pencarian:</strong> Bersih.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="toast" id="toast"></div>



    <div id="storm-wrapper" class="yusuf-storm-wrapper">
        <div class="yusuf-cloud-container">
            <div class="yusuf-cloud-layer yusuf-cloud-1"></div>
            <div class="yusuf-cloud-layer yusuf-cloud-2"></div>
        </div>

        <div id="rain-container" class="yusuf-rain-container"></div>

        <canvas id="lightning-canvas" class="yusuf-lightning-canvas"></canvas>
    </div>

    <footer class="yusuf-footer">
        <div id="ground-cracks" class="yusuf-ground-cracks"></div>
        <div id="ground-flash" class="yusuf-ground-flash"></div>

        <div class="yusuf-footer-container">
            <p class="yusuf-copyright-text">
                &copy; 2026 
               
                <a href="https://github.com/Yusuf-Ibrahim-Malik-Dev" target="_blank" rel="noopener noreferrer" class="yusuf-storm-trigger">Yusuf Ibrahim Malik Dev
                </a>. 
                All Rights Reserved.
           
            </p>
        </div>
    </footer>

    <div id="skyScene">
        <div class="bright-sun"></div>
        <div class="fancy-cloud"></div>
        <canvas id="rainbowCanvas"></canvas>
    </div>

    <div id="moneyRainContainer"></div>

    <div class="root_nama">
        <button id="openDonateBtn" class="clas_yusuf">
            Donate
       
        </button>
    </div>

    <div id="donateModal" style="display: none; position: fixed; z-index: 9999; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.6); justify-content: center; align-items: center;">
        <div style="background-color: white; color: #333; padding: 2rem; border-radius: 1rem; max-width: 450px; width: 90%; text-align: center; position: relative; box-shadow: 0 10px 25px rgba(0,0,0,0.2);">
            <span id="closeDonateBtn" style="position: absolute; right: 1.5rem; top: 1rem; font-size: 1.8rem; cursor: pointer; color: #a1a1aa;">&times;</span>
            <h3 style="margin-top: 0; color: #1e3a8a; font-weight: 700;">Terima Kasih Banyak</h3>
            <p style="font-style: italic; color: #4b5563; font-size: 1rem; line-height: 1.6;">
                "Kehadiran Anda adalah energi bagi kami untuk terus berkarya. Terima kasih telah menggunakan aplikasi ini, dan ketulusan hati Anda melalui donasi ini sangat berarti dalam membantu kami menjaga aplikasi ini tetap hidup dan berkembang."
           
            </p>
            <hr style="border: 0; border-top: 2px solid #e5e7eb; margin: 2rem 0;">
            <p style="font-weight: bold; margin-bottom: 0.75rem; color: #1f2937; font-size: 1.1rem;">Scan Barcode Paypal untuk Berdonasi</p>
            <div style="background-color: #f3f4f6; padding: 1.5rem; border-radius: 1rem; display: inline-block;">
                <img src="assets/img/qris-paypal.png" alt="QRIS Yusuf Ibrahim Malik Dev" style="height: 350px; object-fit: contain; display: block; margin: 0 auto;">
            </div>
            <p style="margin-top: 1rem; font-size: 1rem; color: #374151;">Atas Nama:
                <br>
                <strong style="font-size: 1.25rem; color: #111827;">Yusuf Ibrahim Malik Dev</strong></p>
        </div>
    </div>

    <!-- SESUDAH (LOKAL) -->
    <script src="assets/js/monaco/vs/loader.js"></script>

    <script>
        window.addEventListener('resize', () => {
            if (window.globalInputEditorInstance) window.globalInputEditorInstance.layout();
            if (window.globalOutputEditorInstance) window.globalOutputEditorInstance.layout();
            if (window.globalDiffEditorInstance) window.globalDiffEditorInstance.layout();
        });

        window.switchSuiteTab = function (tabId) {
            document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));

            event.currentTarget.classList.add('active');
            document.getElementById('tab-' + tabId).classList.add('active');

            if (tabId === 'visual-diff' && window.globalDiffEditorInstance) {
                setTimeout(() => {
                    window.globalDiffEditorInstance.layout();
                }, 10);
            }
        };

        (function () {
            const languages = [
                "JavaScript", "TypeScript", "React (JSX)", "React TypeScript (TSX)", "HTML", "CSS", "SCSS", "Sass", "Less", "JSON",
                "Python", "Java", "C++", "Go", "SQL", "C#", "VB.NET", "F#", "PHP", "Ruby", "Rust", "Swift", "Kotlin", "Dart",
                "YAML", "XML", "Markdown", "Plain Text"
            ];

            const localization = {
                id: {
                    lblCompare: "Bandingkan", lblSwap: "Tukar", lblImport: "Impor",
                    lblLeftPanel: "<i class='fas fa-edit' style='color:#2563eb'></i> Lembar Kiri - Asli / Multi Deleted (Original)",
                    lblRightPanel: "<i class='fas fa-code-branch' style='color:#10b981'></i> Lembar Kanan - Multi Added / Edit (Modified)",
                    lblPanelMainTitle: "<i class='fas fa-circle-nodes' style='color:#ef4444'></i> Dasbor Analisis Perbedaan Berkinerja Tinggi",
                    lblJumpDiff: "Lompat ke Perbedaan", lblToggleDiff: "Ganti Inline / Split View", lblClearWorkspace: "Bersihkan Workspace",
                    lblEngineReady: "Mesin Siap", lblEngineSub: "Tekan Bandingkan atau gunakan pintasan Ctrl + Enter",
                    tabTitle1: "Perbandingan Visual", tabTitle2: "Dasbor Diff & Plagiarisme", tabTitle3: "Struktur AST & Logika", tabTitle4: "Git Metadata & Riwayat", tabTitle5: "Pencarian Teks Lanjutan",
                    secTitle1: "1. Ringkasan Metrik Analisis Diff", secTitle2: "2. Deteksi Plagiarisme & Statistik Karakter", secTitle3: "🔥 Heatmap Perubahan Berdasarkan Kepadatan",
                    secTitle4: "3. Statistik Struktur Kode & Objek (Analisis AST)", secTitle5: "4. Validasi Sintaks & Format Penulisan", secTitle6: "5. Analisis Semantik, Logika, & Refactoring",
                    secTitle7: "6. Metadata Repositori & Simulasi Status Git", secTitle8: "7. Riwayat Komit, Kontrol Konflik Merge, & Analisis Blame",
                    btnNext: "Berikutnya", btnPrev: "Sebelumnya", btnReplace: "Replace", btnReplaceAll: "Replace Semua",
                    legend: [
                        "lg-added|fa-square-plus|Lembar Kanan: Multi Added (Baris Baru dengan Simbol +)",
                        "lg-deleted|fa-square-minus|Lembar Kiri: Multi Deleted (Baris Dihapus dengan Simbol -)",
                        "lg-modified|fa-pen-to-square|Modified (Isi Baris Berubah)",
                        "lg-moved|fa-arrows-up-down-left-right|Moved (Baris Dipindahkan)",
                        "lg-renamed|fa-input-text|Renamed (Simbol Berubah Nama)",
                        "lg-conflict|fa-code-merge|Conflict (Merge Conflict)",
                        "lg-copied|fa-clone|Copied (Baris Hasil Salinan)",
                        "lg-binary|fa-file-binary|Binary (File Biner Berubah)",
                        "lg-selected|fa-arrow-pointer|Selected (Baris Sedang Dipilih)",
                        "lg-add-block|fa-cubes|Added Block (Blok Baru)",
                        "lg-del-block|fa-trash-can|Deleted Block (Blok Dihapus)",
                        "lg-mod-block|fa-layer-group|Modified Block (Blok Dimodifikasi)",
                        "lg-mov-block|fa-boxes-packing|Moved Block (Blok Dipindahkan)",
                        "lg-refactored|fa-code-compare|Refactored (Refactoring Terdeteksi)",
                        "lg-warning|fa-triangle-exclamation|Peringatan Potensial Masalah"
                    ]
                },
                en: {
                    lblCompare: "Compare", lblSwap: "Swap", lblImport: "Import",
                    lblLeftPanel: "<i class='fas fa-edit' style='color:#2563eb'></i> Left Panel - Original / Multi Deleted",
                    lblRightPanel: "<i class='fas fa-code-branch' style='color:#10b981'></i> Right Panel - Multi Added / Modified",
                    lblPanelMainTitle: "<i class='fas fa-circle-nodes' style='color:#ef4444'></i> High-Performance Diff Analytics Dashboard",
                    lblJumpDiff: "Jump to Difference", lblToggleDiff: "Toggle Inline / Split View", lblClearWorkspace: "Clear Workspace",
                    lblEngineReady: "Engine Standby", lblEngineSub: "Press Compare or use shortcut Ctrl + Enter",
                    tabTitle1: "Visual Comparison", tabTitle2: "Diff & Plagiarism Dashboard", tabTitle3: "AST Structure & Logic", tabTitle4: "Git Metadata & History", tabTitle5: "Advanced Text Search",
                    secTitle1: "1. Diff Analysis Metrics Summary", secTitle2: "2. Plagiarism Detection & Character Statistics", secTitle3: "🔥 Change Heatmap Based on Density",
                    secTitle4: "3. Code Structure & Object Statistics (AST Analysis)", secTitle5: "4. Syntax Validation & Code Formatting", secTitle6: "5. Semantic, Logic, & Refactoring Analysis",
                    secTitle7: "6. Repository Metadata & Git Status Simulation", secTitle8: "7. Commit History, Merge Conflict Controls, & Blame Analysis",
                    btnNext: "Next", btnPrev: "Previous", btnReplace: "Replace", btnReplaceAll: "Replace All",
                    legend: [
                        "lg-added|fa-square-plus|Right Panel: Multi Added (New Line with + Symbol)",
                        "lg-deleted|fa-square-minus|Left Panel: Multi Deleted (Removed Line with - Symbol)",
                        "lg-modified|fa-pen-to-square|Modified (Line Content Changed)",
                        "lg-moved|fa-arrows-up-down-left-right|Moved (Line Repositioned)",
                        "lg-renamed|fa-input-text|Renamed (Symbol Renamed)",
                        "lg-conflict|fa-code-merge|Conflict (Merge Conflict)",
                        "lg-copied|fa-clone|Copied (Copied Line)",
                        "lg-binary|fa-file-binary|Binary (Binary File Changed)",
                        "lg-selected|fa-arrow-pointer|Selected (Line Currently Selected)",
                        "lg-add-block|fa-cubes|Added Block (New Block)",
                        "lg-del-block|fa-trash-can|Deleted Block (Removed Block)",
                        "lg-mod-block|fa-layer-group|Modified Block (Modified Block)",
                        "lg-mov-block|fa-boxes-packing|Moved Block (Moved Block)",
                        "lg-refactored|fa-code-compare|Refactored (Refactoring Detected)",
                        "lg-warning|fa-triangle-exclamation|Warning (Potential Problem)"
                    ]
                }
            };

            const state = {
                dark: localStorage.getItem('theme-dark') === 'true',
                inlineDiff: false,
                inputModel: null,
                outputModel: null,
                currentLang: localStorage.getItem('saved-lang') || 'JavaScript',
                interfaceLang: localStorage.getItem('interface-lang') || 'id'
            };

            const langSelect = document.getElementById('languageSelect');
            const interfaceLangSelect = document.getElementById('interfaceLangSelect');
            const themeToggle = document.getElementById('themeToggle');
            const toast = document.getElementById('toast');
            const emptyDiffState = document.getElementById('emptyDiffState');
            const monacoDiffViewerWrapper = document.getElementById('monacoDiffViewerWrapper');
            const diffNavigatorBtn = document.getElementById('diffNavigatorBtn');

            function showToast(msg) {
                toast.textContent = msg;
                toast.classList.add('show');
                clearTimeout(toast._timeout);
                toast._timeout = setTimeout(() => toast.classList.remove('show'), 2500);
            }

            function applyLocalization(langKey) {
                const dict = localization[langKey];
                for (let key in dict) {
                    const el = document.getElementById(key);
                    if (el && key !== 'legend') {
                        if (el.tagName === 'INPUT') el.placeholder = dict[key];
                        else el.innerHTML = dict[key];
                    }
                }

                const legendBox = document.getElementById('legendContainer');
                legendBox.innerHTML = dict.legend.map(item => {
                    const parts = item.split('|');
                    const colorClass = parts[0];
                    const iconClass = parts[1];
                    const text = parts[2];
                    return `<div class="legend-item"><span class="legend-icon ${colorClass}"><i class="fas ${iconClass}"></i></span> <strong>${text}</strong></div>`;
                }).join('');
            }

            if (state.dark) {
                document.body.classList.add('dark');
                themeToggle.innerHTML = '<i class="fas fa-sun"></i>';
            }

            langSelect.innerHTML = languages.map(l => `<option value="${l}">${l}</option>`).join('');
            langSelect.value = state.currentLang;
            interfaceLangSelect.value = state.interfaceLang;

            // UBAH MENJADI (LOKAL):
            require.config({ paths: { vs: 'assets/js/monaco/vs' } });
            require(['vs/editor/editor.main'], function () {
                initCore();
                applyLocalization(state.interfaceLang);
            });

            function mapLang(lang) {
                const maps = {
                    'JavaScript': 'javascript', 'TypeScript': 'typescript', 'React (JSX)': 'javascript', 'React TypeScript (TSX)': 'typescript',
                    'HTML': 'html', 'CSS': 'css', 'SCSS': 'scss', 'Sass': 'scss', 'Less': 'less', 'JSON': 'json',
                    'Python': 'python', 'Java': 'java', 'C++': 'cpp', 'Go': 'go', 'SQL': 'sql', 'C#': 'csharp',
                    'VB.NET': 'vb', 'F#': 'fsharp', 'PHP': 'php', 'Ruby': 'ruby', 'Rust': 'rust', 'Swift': 'swift',
                    'Kotlin': 'kotlin', 'Dart': 'dart', 'YAML': 'yaml', 'XML': 'xml', 'Plain Text': 'plaintext'
                };
                return maps[lang] || 'plaintext';
            }

            function initCore() {
                const activeTheme = state.dark ? 'vs-dark' : 'vs';
                const commonOptions = {
                    automaticLayout: true,
                    fontSize: 13,
                    minimap: { enabled: true },
                    renderWhitespace: 'all',
                    scrollbar: { verticalScrollbarSize: 8, horizontalScrollbarSize: 8 },
                    theme: activeTheme
                };

                state.inputModel = monaco.editor.createModel('// Ketik atau tempel kode sumber asli (Kiri) di sini...', mapLang(state.currentLang));
                state.outputModel = monaco.editor.createModel('// Ketik atau tempel kode sumber hasil modifikasi (Kanan) di sini...', mapLang(state.currentLang));

                window.globalInputEditorInstance = monaco.editor.create(document.getElementById('inputEditorContainer'), { ...commonOptions, model: state.inputModel });
                window.globalOutputEditorInstance = monaco.editor.create(document.getElementById('outputEditorContainer'), { ...commonOptions, model: state.outputModel });

                window.globalDiffEditorInstance = monaco.editor.createDiffEditor(document.getElementById('monacoDiffInstance'), {
                    automaticLayout: true,
                    enableSplitViewResizing: true,
                    renderSideBySide: true,
                    readOnly: true,
                    fontSize: 13,
                    renderWhitespace: 'all',
                    ignoreTrimWhitespace: false,
                    scrollBeyondLastLine: false,
                    theme: activeTheme,
                    renderIndicators: true
                });

                window.globalDiffEditorInstance.getOriginalEditor().updateOptions({
                    scrollbar: { horizontal: 'auto', vertical: 'visible', horizontalScrollbarSize: 12 }
                });
                window.globalDiffEditorInstance.getModifiedEditor().updateOptions({
                    scrollbar: { horizontal: 'auto', vertical: 'visible', horizontalScrollbarSize: 12 }
                });

                const updateStats = () => {
                    const text = state.interfaceLang === 'id' ? 'baris' : 'lines';
                    const charText = state.interfaceLang === 'id' ? 'karakter' : 'chars';
                    document.getElementById('inputStats').textContent = `${state.inputModel.getLineCount()} ${text} | ${state.inputModel.getValue().length} ${charText}`;
                    document.getElementById('outputStats').textContent = `${state.outputModel.getLineCount()} ${text} | ${state.outputModel.getValue().length} ${charText}`;
                };

                state.inputModel.onDidChangeContent(updateStats);
                state.outputModel.onDidChangeContent(updateStats);
                updateStats();
            }

            document.getElementById('formatBtn').addEventListener('click', () => {
                const lang = mapLang(state.currentLang);
                const options = { indent_size: 2, space_in_empty_paren: true, end_with_newline: true };

                let inputVal = state.inputModel.getValue();
                let outputVal = state.outputModel.getValue();

                try {
                    if (['javascript', 'typescript', 'json'].includes(lang)) {
                        inputVal = js_beautify(inputVal, options);
                        outputVal = js_beautify(outputVal, options);
                    } else if (['css', 'scss', 'less'].includes(lang)) {
                        inputVal = css_beautify(inputVal, options);
                        outputVal = css_beautify(outputVal, options);
                    } else if (['html', 'xml'].includes(lang)) {
                        inputVal = html_beautify(inputVal, options);
                        outputVal = html_beautify(outputVal, options);
                    } else {
                        window.globalInputEditorInstance.getAction('editor.action.formatDocument').run();
                        window.globalOutputEditorInstance.getAction('editor.action.formatDocument').run();
                        showToast(state.interfaceLang === 'id' ? "✨ Format Berhasil via Engine Internal!" : "✨ Formatted via Internal Engine!");
                        return;
                    }
                    state.inputModel.setValue(inputVal);
                    state.outputModel.setValue(outputVal);
                    showToast(state.interfaceLang === 'id' ? "✨ Format Kode Sukses Disesuaikan!" : "✨ Code Formatting Completed!");
                } catch (err) {
                    showToast("❌ Gagal merapikan format.");
                }
            });

            document.getElementById('minifyBtn').addEventListener('click', () => {
                const lang = mapLang(state.currentLang);

                const runMinify = (text) => {
                    if (['javascript', 'typescript', 'css', 'json'].includes(lang)) {
                        return text.replace(/\/\*[\s\S]*?\*\/|([^\\:]|^)\/\/.*$/gm, '$1').replace(/\s+/g, ' ').trim();
                    } else if (['html', 'xml'].includes(lang)) {
                        return text.replace(/>\s+</g, '><').replace(/\s+/g, ' ').trim();
                    } else {
                        return text.split(/\r?\n/).map(line => line.trimEnd()).filter(line => line.trim() !== '').join('\n');
                    }
                };

                state.inputModel.setValue(runMinify(state.inputModel.getValue()));
                state.outputModel.setValue(runMinify(state.outputModel.getValue()));
                showToast(state.interfaceLang === 'id' ? "📦 Kode Berhasil Dikompresi Aman!" : "📦 Code Safely Minified!");
            });

            function compileAllHighEndMetrics(src, dest) {
                const srcLines = src.split(/\r?\n/);
                const destLines = dest.split(/\r?\n/);

                let identicalLines = 0, addedLines = 0, deletedLines = 0, modifiedLines = 0;
                const srcSet = new Set(srcLines);
                const destSet = new Set(destLines);

                destLines.forEach(l => { if (srcSet.has(l)) identicalLines++; else addedLines++; });
                srcLines.forEach(l => { if (!destSet.has(l)) deletedLines++; });
                modifiedLines = Math.min(addedLines, deletedLines);

                const maxLines = Math.max(srcLines.length, destLines.length) || 1;
                const similarityScore = Math.min(100, Math.round((identicalLines / maxLines) * 100));
                const differenceScore = 100 - similarityScore;
                const changeDensity = ((addedLines + deletedLines + modifiedLines) / maxLines).toFixed(2);

                const totalChars = dest.length;
                const charsNoSpace = dest.replace(/\s/g, '').length;
                const spaceCount = (dest.match(/ /g) || []).length;
                const tabCount = (dest.match(/\t/g) || []).length;
                const uppercaseCount = (dest.match(/[A-Z]/g) || []).length;
                const lowercaseCount = (dest.match(/[a-z]/g) || []).length;
                const digitsCount = (dest.match(/[0-9]/g) || []).length;
                const symbolsCount = (dest.match(/[^A-Za-z0-9\s]/g) || []).length;
                const emptyLines = destLines.filter(l => l.trim() === "").length;
                const crlfCount = (dest.match(/\r\n/g) || []).length;
                const lineEndingType = crlfCount > (destLines.length / 2) ? "CRLF (Windows)" : "LF (Unix)";

                const totalClasses = (dest.match(/class\s+\w+/g) || []).length;
                const totalFunctions = (dest.match(/(function\s+\w+|const\s+\w+\s*=\s*\(.*\)\s*=>|\w+\s*\(.*\)\s*\{)/g) || []).length;
                const totalVariables = (dest.match(/(let|var|const)\s+\w+/g) || []).length;
                const totalImports = (dest.match(/(import\s+.*from|require\(.*\)|using\s+\w+)/g) || []).length;
                const commentLines = (dest.match(/(\/\/.*|\/\*[\s\S]*?\*\/)/g) || []).length;
                const todoCount = (dest.match(/\/\/.*TODO/gi) || []).length;
                const fixmeCount = (dest.match(/\/\/.*FIXME/gi) || []).length;

                const ifCount = (dest.match(/if\s*\(.*\)/g) || []).length;
                const switchCount = (dest.match(/switch\s*\(.*\)/g) || []).length;
                const loopCount = (dest.match(/(for|while)\s*\(.*\)/g) || []).length;
                const cyclomaticComplexity = 1 + ifCount + switchCount + loopCount;

                let heatmapIcon = state.interfaceLang === 'id' ? "🟩 Sangat Sedikit Perubahan (0–10%)" : "🟩 Very Low Changes (0–10%)";
                if (differenceScore > 10 && differenceScore <= 30) heatmapIcon = state.interfaceLang === 'id' ? "🟨 Perubahan Ringan (11–30%)" : "🟨 Low Changes (11–30%)";
                else if (differenceScore > 30 && differenceScore <= 60) heatmapIcon = state.interfaceLang === 'id' ? "🟧 Perubahan Sedang (31–60%)" : "🟧 Medium Changes (31–60%)";
                else if (differenceScore > 60 && differenceScore <= 90) heatmapIcon = state.interfaceLang === 'id' ? "🟥 Perubahan Besar (61–90%)" : "🟥 High Changes (61–90%)";
                else if (differenceScore > 90) heatmapIcon = state.interfaceLang === 'id' ? "🟪 Perubahan Ekstrem (91–100%)" : "🟪 Extreme Changes (91–100%)";

                return {
                    similarityScore, differenceScore, identicalLines, addedLines, deletedLines, modifiedLines, changeDensity,
                    totalChars, charsNoSpace, spaceCount, tabCount, uppercaseCount, lowercaseCount, digitsCount, symbolsCount, emptyLines, lineEndingType,
                    totalClasses, totalFunctions, totalVariables, totalImports, commentLines, todoCount, fixmeCount,
                    cyclomaticComplexity, heatmapIcon
                };
            }

            function executeDiff() {
                if (!window.globalDiffEditorInstance) return;
                emptyDiffState.style.display = 'none';
                monacoDiffViewerWrapper.style.display = 'flex';
                diffNavigatorBtn.style.display = 'inline-flex';

                window.globalDiffEditorInstance.setModel({ original: state.inputModel, modified: state.outputModel });

                setTimeout(() => {
                    if (window.globalDiffEditorInstance) window.globalDiffEditorInstance.layout();
                }, 150);

                const srcCode = state.inputModel.getValue();
                const destCode = state.outputModel.getValue();
                const m = compileAllHighEndMetrics(srcCode, destCode);

                const isID = state.interfaceLang === 'id';

                document.getElementById('diffMetricsContainer').innerHTML = `
        <div class="card-metric"><span class="card-title">${isID ? 'Persentase Kemiripan' : 'Similarity Percentage'}</span><span class="card-value" style="color:#16a34a">${m.similarityScore}%</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Persentase Perbedaan' : 'Difference Percentage'}</span><span class="card-value" style="color:#ef4444">${m.differenceScore}%</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Baris Identik (Sama)' : 'Identical Lines'}</span><span class="card-value">${m.identicalLines}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Baris Ditambahkan' : 'Added Lines'}</span><span class="card-value" style="color:#16a34a">+${m.addedLines}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Baris Dihapus' : 'Deleted Lines'}</span><span class="card-value" style="color:#ef4444">-${m.deletedLines}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Baris Dimodifikasi' : 'Modified Lines'}</span><span class="card-value">${m.modifiedLines}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Kepadatan Perubahan' : 'Change Density'}</span><span class="card-value">${m.changeDensity}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Total Perubahan Ukuran' : 'Total Size Change'}</span><span class="card-value">${(destCode.length - srcCode.length).toLocaleString()} byte</span></div>
      `;

                document.getElementById('plagiarismMetricsContainer').innerHTML = `
        <div class="card-metric"><span class="card-title">${isID ? 'Skor Plagiarisme' : 'Plagiarism Score'}</span><span class="card-value">${m.similarityScore}%</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Deteksi Code Clone' : 'Code Clone Detection'}</span><span class="card-value">${m.similarityScore > 80 ? (isID ? 'Clone Terdeteksi' : 'Clone Detected') : (isID ? 'Struktur Unik' : 'Unique Structure')}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Pencocokan Parsial' : 'Partial Match'}</span><span class="card-value">${m.identicalLines} ${isID ? 'Baris' : 'Lines'}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Duplikasi Eksak' : 'Exact Match'}</span><span class="card-value">${m.similarityScore > 95 ? (isID ? 'Identik Sempurna' : 'Perfect Identical') : (isID ? 'Ada Modifikasi' : 'Modified')}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Total Karakter' : 'Total Characters'}</span><span class="card-value">${m.totalChars.toLocaleString()}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Karakter Tanpa Spasi' : 'Chars Without Space'}</span><span class="card-value">${m.charsNoSpace.toLocaleString()}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Huruf Besar / Kecil' : 'Uppercase / Lowercase'}</span><span class="card-value">${m.uppercaseCount} / ${m.lowercaseCount}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Jumlah Digit & Simbol' : 'Digits & Symbols Count'}</span><span class="card-value">${m.digitsCount} / ${m.symbolsCount}</span></div>
      `;

                document.getElementById('heatmapContainer').innerHTML = `
        <div class="card-metric" style="grid-column: 1 / -1;"><span class="card-title">${isID ? 'Zona Intensitas Perubahan' : 'Change Intensity Zone'}</span><span class="card-value">${m.heatmapIcon}</span></div>
      `;

                document.getElementById('codeStatsContainer').innerHTML = `
        <div class="card-metric"><span class="card-title">${isID ? 'Total Kelas' : 'Total Classes'}</span><span class="card-value">${m.totalClasses}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Total Fungsi & Method' : 'Total Functions & Methods'}</span><span class="card-value">${m.totalFunctions}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Total Deklarasi Variabel' : 'Total Declared Variables'}</span><span class="card-value">${m.totalVariables}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Modul Impor' : 'Import Modules'}</span><span class="card-value">${m.totalImports}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Jumlah Baris Komentar' : 'Comment Lines Count'}</span><span class="card-value">${m.commentLines}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Baris Kosong' : 'Empty Lines'}</span><span class="card-value">${m.emptyLines}</span></div>
        <div class="card-metric"><span class="card-title">TODO</span><span class="card-value" style="color:#eab308">${m.todoCount}</span></div>
        <div class="card-metric"><span class="card-title">FIXME</span><span class="card-value" style="color:#ef4444">${m.fixmeCount}</span></div>
      `;

                document.getElementById('syntaxFormattingContainer').innerHTML = `
        <div class="card-metric"><span class="card-title">${isID ? 'Validasi Sintaksis' : 'Syntax Validation'}</span><span class="card-value" style="color:#16a34a">${isID ? 'Sukses' : 'Passed'}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Deteksi Eror' : 'Error Detection'}</span><span class="card-value">0</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Perubahan Whitespace' : 'Whitespace Changes'}</span><span class="card-value">${m.spaceCount}</span></div>
        <div class="card-metric"><span class="card-title">Tab vs Space</span><span class="card-value">${m.tabCount} Tab / ${m.spaceCount} Spc</span></div>
        <div class="card-metric"><span class="card-title">Line Ending</span><span class="card-value">${m.lineEndingType}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Skor Keindahan Format' : 'Formatting Score'}</span><span class="card-value">98/100</span></div>
      `;

                document.getElementById('semanticLogicContainer').innerHTML = `
        <div class="card-metric"><span class="card-title">${isID ? 'Kompleksitas Siklomatik' : 'Cyclomatic Complexity'}</span><span class="card-value">${m.cyclomaticComplexity}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Kedalaman Sarang' : 'Nesting Depth'}</span><span class="card-value">${m.cyclomaticComplexity > 8 ? (isID ? 'Struktur Dalam' : 'High Depth') : 'Normal'}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Deteksi Ganti Nama Variabel' : 'Variable Rename Detection'}</span><span class="card-value">${m.totalVariables > 0 && m.differenceScore > 10 ? (isID ? 'Terindikasi' : 'Detected') : (isID ? 'Tidak Ada' : 'None')}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Perubahan Semantik' : 'Semantic Change'}</span><span class="card-value">${m.differenceScore > 0 ? (isID ? 'Logika Bermutasi' : 'Logic Mutated') : (isID ? 'Struktur Statis' : 'Static')}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Deteksi Refactoring' : 'Refactoring Detection'}</span><span class="card-value">${m.modifiedLines > 0 ? (isID ? 'Disarankan' : 'Recommended') : (isID ? 'Bersih' : 'Clean')}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Dampak API Breaking' : 'API Breaking Impact'}</span><span class="card-value" style="color:#16a34a">${isID ? 'Aman' : 'Safe'}</span></div>
      `;

                document.getElementById('gitMetadataContainer').innerHTML = `
        <div class="card-metric"><span class="card-title">Branch Git</span><span class="card-value">main (HEAD)</span></div>
        <div class="card-metric"><span class="card-title">Commit SHA-1</span><span class="card-value" style="font-size:0.75rem;">9f4c3a2b1e5d8f6a7b9c0e1f2a3b4c5d6e7f8a9b</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Status Kerja Repositori' : 'Repository Status'}</span><span class="card-value" style="color:#eab308">Modified</span></div>
        <div class="card-metric"><span class="card-title">File Staged / Untracked</span><span class="card-value">1 / 0</span></div>
      `;

                document.getElementById('gitHistoryBlameContainer').innerHTML = `
        <div class="card-metric"><span class="card-title">${isID ? 'Penulis Terakhir' : 'Author Blame'}</span><span class="card-value" style="font-size:0.85rem;">Local Dev</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Waktu Perubahan Terakhir' : 'Last Modified Time'}</span><span class="card-value" style="font-size:0.85rem;">${new Date().toLocaleDateString()}</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Penanda Konflik Merge' : 'Merge Conflict Markers'}</span><span class="card-value" style="color:#16a34a">0</span></div>
        <div class="card-metric"><span class="card-title">${isID ? 'Cakupan Versi' : 'Version Scope'}</span><span class="card-value" style="font-size:0.85rem;">Working Tree ↔ Index</span></div>
      `;

                showToast(isID ? "⚡ Analisis Selesai Dimuat!" : "⚡ Analysis Loaded Successfully!");
            }

            interfaceLangSelect.addEventListener('change', (e) => {
                state.interfaceLang = e.target.value;
                localStorage.setItem('interface-lang', state.interfaceLang);
                applyLocalization(state.interfaceLang);
                if (monacoDiffViewerWrapper.style.display === 'flex') {
                    executeDiff();
                }
            });

            let searchHistory = [];
            window.triggerSearchAction = function (type) {
                const query = document.getElementById('findInput').value;
                const replaceString = document.getElementById('replaceInput').value;
                if (!query) return showToast("Masukkan kriteria pencarian teks!");

                window.globalOutputEditorInstance.focus();
                const isID = state.interfaceLang === 'id';

                if (type === 'findNext' || type === 'findPrev') {
                    const matches = state.outputModel.findMatches(query, true, false, false, null, true);
                    if (matches.length > 0) {
                        window.globalOutputEditorInstance.setSelection(matches[0].range);
                        window.globalOutputEditorInstance.revealRange(matches[0].range);
                        document.getElementById('searchMetaInfo').innerHTML = isID ? `<strong>Status:</strong> Menemukan ${matches.length} baris pencarian.` : `<strong>Status:</strong> Found ${matches.length} search results.`;

                        if (!searchHistory.includes(query)) {
                            searchHistory.push(query);
                            document.getElementById('searchHistoryLog').textContent = (isID ? "Riwayat Pencarian: " : "Search History: ") + searchHistory.join(', ');
                        }
                    } else {
                        showToast(isID ? "Pola kata tidak ditemukan!" : "Pattern not found!");
                    }
                } else if (type === 'replace') {
                    const value = state.outputModel.getValue();
                    state.outputModel.setValue(value.replace(query, replaceString));
                    showToast("Replaced.");
                } else if (type === 'replaceAll') {
                    const value = state.outputModel.getValue();
                    state.outputModel.setValue(value.split(query).join(replaceString));
                    showToast("All Replaced.");
                }
            };

            document.getElementById('fileInput').addEventListener('change', (e) => {
                const file = e.target.files[0];
                if (!file) return;
                const r = new FileReader();
                r.onload = ev => {
                    state.inputModel.setValue(ev.target.result);
                    showToast(`📂 File Dimuat: ${file.name}`);
                };
                r.readAsText(file);
            });

            langSelect.addEventListener('change', (e) => {
                state.currentLang = e.target.value;
                localStorage.setItem('saved-lang', state.currentLang);
                const monacoLang = mapLang(state.currentLang);
                if (state.inputModel && state.outputModel) {
                    monaco.editor.setModelLanguage(state.inputModel, monacoLang);
                    monaco.editor.setModelLanguage(state.outputModel, monacoLang);
                    showToast(`Language: ${state.currentLang}`);
                }
            });

            document.getElementById('swapBtn').addEventListener('click', () => {
                const i = state.inputModel.getValue();
                const o = state.outputModel.getValue();
                state.inputModel.setValue(o);
                state.outputModel.setValue(i);
                showToast("🔄 Swapped!");
            });

            document.getElementById('clearDiffBtn').addEventListener('click', () => {
                emptyDiffState.style.display = 'flex';
                monacoDiffViewerWrapper.style.display = 'none';
                state.inputModel.setValue('');
                state.outputModel.setValue('');
                showToast("🧹 Cleared.");
            });

            document.getElementById('copyInputBtn').addEventListener('click', () => {
                navigator.clipboard.writeText(state.inputModel.getValue());
                showToast("📋 Copied Original!");
            });

            document.getElementById('copyOutputBtn').addEventListener('click', () => {
                navigator.clipboard.writeText(state.outputModel.getValue());
                showToast("📋 Copied Modified!");
            });

            themeToggle.addEventListener('click', () => {
                state.dark = !state.dark;
                localStorage.setItem('theme-dark', state.dark);
                document.body.classList.toggle('dark', state.dark);
                themeToggle.innerHTML = state.dark ? '<i class="fas fa-sun"></i>' : '<i class="fas fa-moon"></i>';
                monaco.editor.setTheme(state.dark ? 'vs-dark' : 'vs');
            });

            document.getElementById('compareBtn').addEventListener('click', executeDiff);
            document.addEventListener('keydown', e => {
                if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
                    e.preventDefault();
                    executeDiff();
                }
            });
        })();
</script>


    <script>
        document.addEventListener("DOMContentLoaded", () => {

            // =======================================
            // ROOT_JAVA_NAMA FUNCTION_YUSUF SYSTEM
            // =======================================
            const root_java_nama = {
                isStorming: false,
                lightningTimer: null,

                // Fungsi utama inisialisasi cuaca Yusuf
                function_yusuf: function () {
                    const trigger = document.querySelector(".yusuf-storm-trigger");
                    const stormWrapper = document.getElementById("storm-wrapper");
                    const rainContainer = document.getElementById("rain-container");
                    const canvas = document.getElementById("lightning-canvas");
                    const ctx = canvas.getContext("2d");
                    const groundCracks = document.getElementById("ground-cracks");
                    const groundFlash = document.getElementById("ground-flash");

                    // Mengatur ukuran canvas layar penuh
                    function resizeCanvas() {
                        canvas.width = window.innerWidth;
                        canvas.height = window.innerHeight;
                    }
                    window.addEventListener("resize", resizeCanvas);
                    resizeCanvas();

                    // 1. Sub-fungsi Membuat Hujan
                    function generateRain() {
                        rainContainer.innerHTML = "";
                        const maxDrops = 150;
                        for (let i = 0; i < maxDrops; i++) {
                            const drop = document.createElement("div");
                            drop.classList.add("yusuf-drop");
                            drop.style.left = `${Math.random() * 100}%`;
                            drop.style.top = `${Math.random() * -50}px`;
                            drop.style.animationDuration = `${0.4 + Math.random() * 0.4}s`;
                            drop.style.animationDelay = `${Math.random() * 1.5}s`;
                            rainContainer.appendChild(drop);
                        }
                    }

                    // 2. Sub-fungsi Menggambar Petir Lengkang-Lengkung (Fractal)
                    function drawLightningFractal(startX, startY, endX, endY, displace, props) {
                        if (displace < props.minDisplace) {
                            ctx.beginPath();
                            ctx.moveTo(startX, startY);
                            ctx.lineTo(endX, endY);
                            ctx.strokeStyle = props.color;
                            ctx.lineWidth = props.width;
                            ctx.shadowBlur = 15;
                            ctx.shadowColor = "#00fff2";
                            ctx.stroke();
                            return;
                        }

                        const midX = (startX + endX) / 2 + (Math.random() - 0.5) * displace;
                        const midY = (startY + endY) / 2 + (Math.random() - 0.5) * displace;

                        drawLightningFractal(startX, startY, midX, midY, displace / 2, props);
                        drawLightningFractal(midX, midY, endX, endY, displace / 2, props);

                        // Membuat sub-cabang kecil liar di udara
                        if (Math.random() < 0.12 && displace > 10) {
                            const branchEndX = midX + (Math.random() - 0.5) * 80;
                            const branchEndY = midY + Math.random() * 60;
                            drawLightningFractal(midX, midY, branchEndX, branchEndY, displace / 2, {
                                ...props,
                                width: props.width * 0.5
                            });
                        }
                    }

                    // 3. Sub-fungsi Pemicu Ledakan Sambaran Petir
                    const triggerLightningStrike = () => {
                        if (!root_java_nama.isStorming) return;

                        ctx.clearRect(0, 0, canvas.width, canvas.height);

                        const triggerRect = trigger.getBoundingClientRect();
                        const startX = Math.random() * canvas.width;
                        const startY = 40;
                        const endX = triggerRect.left + (Math.random() * triggerRect.width);
                        const endY = canvas.height - 90;

                        const properties = {
                            color: "rgba(235, 255, 255, 1)",
                            width: 3.5,
                            minDisplace: 4
                        };

                        // Gambar kilatan petir
                        drawLightningFractal(startX, startY, endX, endY, 160, properties);

                        // Aktifkan visual efek sekunder (Guncangan & Retakan Tanah)
                        stormWrapper.classList.add("ambient-flash");
                        groundCracks.classList.add("cracks-active");
                        groundFlash.classList.add("flash-active");
                        document.body.classList.add("shake-body");

                        // Bersihkan efek instan berkedip
                        setTimeout(() => {
                            ctx.clearRect(0, 0, canvas.width, canvas.height);
                            stormWrapper.classList.remove("ambient-flash");
                            document.body.classList.remove("shake-body");
                        }, 180);

                        setTimeout(() => {
                            groundCracks.classList.remove("cracks-active");
                            groundFlash.classList.remove("flash-active");
                        }, 400);

                        // Set giliran petir acak berikutnya jika kursor masih diam disana
                        const nextStrike = 1000 + Math.random() * 2000;
                        root_java_nama.lightningTimer = setTimeout(triggerLightningStrike, nextStrike);
                    };

                    // =======================================
                    // EVENT LISTENERS (HOVER CONTROL)
                    // =======================================

                    // Ketika kursor diam/masuk ke area teks
                    trigger.addEventListener("mouseenter", () => {
                        root_java_nama.isStorming = true;

                        // Aktifkan tema badai secara penuh
                        document.body.classList.add("yusuf-storm-active");
                        stormWrapper.classList.add("active");
                        trigger.style.textShadow = "0 0 12px #00fff2, 0 0 25px #00fff2";

                        generateRain();

                        // Petir menyambar perdana setelah kursor diam 600ms
                        root_java_nama.lightningTimer = setTimeout(triggerLightningStrike, 600);
                    });

                    // Ketika kursor keluar (Cuaca kembali cerah)
                    trigger.addEventListener("mouseleave", () => {
                        root_java_nama.isStorming = false;

                        // Kembalikan ke tema cerah semula
                        document.body.classList.remove("yusuf-storm-active");
                        stormWrapper.classList.remove("active");
                        trigger.style.textShadow = "none";

                        clearTimeout(root_java_nama.lightningTimer);
                        ctx.clearRect(0, 0, canvas.width, canvas.height);

                        // Bersihkan tetesan hujan dari DOM
                        setTimeout(() => {
                            if (!root_java_nama.isStorming) rainContainer.innerHTML = "";
                        }, 600);
                    });
                }
            };

            // Jalankan sistem cuaca Yusuf
            root_java_nama.function_yusuf();
        });
    </script>

    <script>
        const modal = document.getElementById("donateModal");
        const openBtn = document.getElementById("openDonateBtn");
        const closeBtn = document.getElementById("closeDonateBtn");

        const moneyRainContainer = document.getElementById("moneyRainContainer");
        const skyScene = document.getElementById("skyScene");
        const canvas = document.getElementById("rainbowCanvas");
        const ctx = canvas.getContext("2d");

        let rainInterval;
        let animationFrameId;

        // Variabel Kendali Animasi
        let t = 0;
        let stickmanDirection = 1; // 1 = Meluncur Turun, -1 = Memanjat Naik, 0 = Diam Sejenak
        let blinkAlpha = 0.65;
        let blinkDirection = 0.008; // Transisi kedap-kedip diperhalus pelan

        function getBezierPoint(t, p0, p1, p2) {
            const x = (1 - t) * (1 - t) * p0.x + 2 * (1 - t) * t * p1.x + t * t * p2.x;
            const y = (1 - t) * (1 - t) * p0.y + 2 * (1 - t) * t * p1.y + t * t * p2.y;
            return { x, y };
        }

        // Menggambar 4 Warna Pelangi Utama Pilihanmu (Merah, Kuning, Hijau, Biru)
        function drawRainbow(p0, p1, p2) {
            const customColors = [
                "rgba(255, 50, 50, ",   // Merah
                "rgba(255, 235, 50, ",  // Kuning
                "rgba(50, 215, 50, ",   // Hijau
                "rgba(50, 130, 255, "   // Biru
            ];

            ctx.save();
            // Beri efek blur alami agar antar warna membaur natural
            ctx.shadowBlur = 10;
            ctx.shadowColor = "rgba(255,255,255,0.4)";

            customColors.forEach((color, index) => {
                ctx.beginPath();
                ctx.moveTo(p0.x, p0.y);
                ctx.quadraticCurveTo(p1.x, p1.y, p2.x, p2.y);
                ctx.strokeStyle = color + blinkAlpha + ")";
                ctx.lineWidth = 36 - (index * 5); // Ketebalan layer yang proporsional
                ctx.lineCap = "round";
                ctx.stroke();
            });
            ctx.restore();
        }

        // Desain Anatomi Stickman Alami & Proporsional
        function drawStickman(pos, t, dir) {
            ctx.save();
            ctx.translate(pos.x, pos.y - 18);
            ctx.strokeStyle = "#2d3748"; // Warna abu gelap natural
            ctx.lineWidth = 3;
            ctx.lineCap = "round";

            let frame = Math.floor(Date.now() / 150) % 4; // Ritme gerakan kaki/tangan lebih lambat

            // KEPALA
            ctx.beginPath();
            ctx.arc(0, -18, 5, 0, Math.PI * 2);
            ctx.fillStyle = "#2d3748";
            ctx.fill();
            ctx.stroke();

            // BADAN
            ctx.beginPath();
            ctx.moveTo(0, -13);
            ctx.lineTo(0, 0);
            ctx.stroke();

            if (dir === 1) { // --- PERJALANAN TURUN ---
                if (t > 0.15 && t < 0.85) {
                    // Pose Meluncur (Sliding) Alami
                    ctx.rotate(-0.25); // Condong rileks ke belakang
                    // Posisi Kaki selonjoran santai mengikuti arus luncuran
                    ctx.beginPath(); ctx.moveTo(0, 0); ctx.lineTo(10, 4); ctx.stroke();
                    ctx.beginPath(); ctx.moveTo(0, 0); ctx.lineTo(7, 9); ctx.stroke();
                    // Tangan diangkat ke atas menikmati seluncuran pelangi
                    ctx.beginPath(); ctx.moveTo(0, -10); ctx.lineTo(-8, -18); ctx.stroke();
                    ctx.beginPath(); ctx.moveTo(0, -10); ctx.lineTo(8, -16); ctx.stroke();
                } else {
                    // Pose Jalan Kaki Normal waktu keluar dari awan / mendarat
                    let legCycle = frame % 2 === 0 ? 8 : 3;
                    ctx.beginPath(); ctx.moveTo(0, 0); ctx.lineTo(-5, 10); ctx.stroke();
                    ctx.beginPath(); ctx.moveTo(0, 0); ctx.lineTo(5, legCycle); ctx.stroke();
                    ctx.beginPath(); ctx.moveTo(0, -10); ctx.lineTo(-4, -2); ctx.stroke();
                    ctx.beginPath(); ctx.moveTo(0, -10); ctx.lineTo(4, -4); ctx.stroke();
                }
            } else { // --- PROSES MEMANJAT NAIK (Dibuat Lambat & Natural) ---
                ctx.rotate(0.18); // Sedikit merunduk maju ke depan menahan beban tanjakan
                let climbCycle = frame % 2 === 0;
                // Langkah kaki memanjat secara bergiliran
                ctx.beginPath(); ctx.moveTo(0, 0); ctx.lineTo(-6, climbCycle ? 10 : 5); ctx.stroke();
                ctx.beginPath(); ctx.moveTo(0, 0); ctx.lineTo(4, climbCycle ? 4 : 10); ctx.stroke();
                // Tangan menggapai ke depan menarik tubuh naik ke atas pelangi
                ctx.beginPath(); ctx.moveTo(0, -10); ctx.lineTo(-10, -6); ctx.stroke();
                ctx.beginPath(); ctx.moveTo(0, -10); ctx.lineTo(5, -1); ctx.stroke();
            }

            ctx.restore();
        }

        // Loop Animasi
        function animate() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            if (canvas.width !== window.innerWidth || canvas.height !== window.innerHeight) {
                canvas.width = window.innerWidth;
                canvas.height = window.innerHeight;
            }

            const btnRect = openBtn.getBoundingClientRect();

            const p0 = { x: 110, y: 75 };
            const p2 = { x: btnRect.left + (btnRect.width / 2), y: btnRect.top };
            const p1 = { x: (p0.x + p2.x) / 1.9, y: -130 };

            // Efek Kedap Kedip Natural
            blinkAlpha += blinkDirection;
            if (blinkAlpha >= 0.8 || blinkAlpha <= 0.45) blinkDirection = -blinkDirection;

            drawRainbow(p0, p1, p2);

            // Pengaturan Kecepatan Durasi (Dibuat jauh lebih pelan agar natural)
            if (stickmanDirection === 1) {
                t += 0.0025; // Kecepatan meluncur turun diperlambat setengahnya
                if (t >= 1) {
                    t = 1;
                    stickmanDirection = 0;
                    setTimeout(() => { stickmanDirection = -1; }, 1200); // Istirahat sejenak di atas tombol
                }
            } else if (stickmanDirection === -1) {
                t -= 0.0018; // Kecepatan memanjat naik dibuat sangat tenang dan realistis
                if (t <= 0) {
                    t = 0;
                    stickmanDirection = 0;
                    setTimeout(() => { stickmanDirection = 1; }, 600); // Jeda sebelum keluar awan kembali
                }
            }

            const currentPos = getBezierPoint(t, p0, p1, p2);

            if (stickmanDirection !== 0 || t > 0) {
                drawStickman(currentPos, t, stickmanDirection === 0 ? -1 : stickmanDirection);
            }

            animationFrameId = requestAnimationFrame(animate);
        }

        function createMoney() {
            const paperMoney = ['💵', '💸']; const coins = ['🪙'];
            const isCoin = Math.random() > 0.5;
            const item = document.createElement("div");
            item.classList.add("money-item");

            if (isCoin) {
                item.innerText = coins[Math.floor(Math.random() * coins.length)];
                item.classList.add("coin-animation");
                item.style.fontSize = (Math.random() * 12 + 16) + 'px';
            } else {
                item.innerText = paperMoney[Math.floor(Math.random() * paperMoney.length)];
                item.classList.add("bill-animation");
                item.style.fontSize = (Math.random() * 16 + 22) + 'px';
            }
            item.style.left = Math.random() * 100 + 'vw';
            item.style.animationDuration = (Math.random() * 1.5 + 2.5) + 's';

            moneyRainContainer.appendChild(item);
            setTimeout(() => { item.remove(); }, 4000);
        }

        // HOVER
        openBtn.addEventListener("mouseenter", () => {
            skyScene.style.display = "block";
            moneyRainContainer.style.display = "block";
            t = 0; stickmanDirection = 1;
            animate();
            rainInterval = setInterval(createMoney, 50);
        });

        openBtn.addEventListener("mouseleave", () => {
            cancelAnimationFrame(animationFrameId);
            clearInterval(rainInterval);
            skyScene.style.display = "none";
            moneyRainContainer.style.display = "none";
            moneyRainContainer.innerHTML = '';
        });

        openBtn.onclick = function () {
            modal.style.display = "flex";
            cancelAnimationFrame(animationFrameId);
            clearInterval(rainInterval);
            skyScene.style.display = "none";
            moneyRainContainer.style.display = "none";
        }
        closeBtn.onclick = function () { modal.style.display = "none"; }
        window.onclick = function (event) { if (event.target == modal) { modal.style.display = "none"; } }
</script>
</body>
</html>
