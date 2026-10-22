const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const CHROME_PATH = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe";
const WORKSPACE_DIR = "C:\\Chirag\\Android\\Codes\\Skillora_Complete_Package";
const TEMP_DIR = "C:\\Users\\Chirag\\AppData\\Local\\Temp";
const ASSETS_DIR = path.join(WORKSPACE_DIR, "Marketplace_Assets");

// Base64 Logo
const logoPath = path.join(WORKSPACE_DIR, "Student_App", "assets", "images", "app_logo.png");
const logoBase64 = fs.readFileSync(logoPath).toString('base64');
const logoSrc = `data:image/png;base64,${logoBase64}`;

// Ensure output directories exist
const dirIcon = path.join(ASSETS_DIR, "01_Icon");
const dirCover = path.join(ASSETS_DIR, "02_Cover_Preview");
const dirGallery = path.join(ASSETS_DIR, "03_Screenshots_Gallery");

[dirIcon, dirCover, dirGallery].forEach(dir => {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
});

// Helper: render HTML to image using Chrome headless
function renderScreenshot(htmlContent, width, height, finalOutputPath) {
  const tempHtml = path.join(TEMP_DIR, `temp_render_${Date.now()}_${Math.random().toString(36).substring(7)}.html`);
  const tempPng = path.join(TEMP_DIR, `temp_out_${Date.now()}_${Math.random().toString(36).substring(7)}.png`);

  fs.writeFileSync(tempHtml, htmlContent, 'utf8');

  const cmd = `"${CHROME_PATH}" --headless=new --no-sandbox --window-size=${width},${height} --hide-scrollbars --screenshot="${tempPng}" "file:///${tempHtml.replace(/\\/g, '/')}"`;

  try {
    execSync(cmd, { stdio: 'pipe', timeout: 30000 });
  } catch (err) {
    console.error(`Chrome execution error:`, err.message);
  }

  // Poll for tempPng
  let attempts = 0;
  while (!fs.existsSync(tempPng) && attempts < 20) {
    execSync('powershell -Command "Start-Sleep -Milliseconds 200"');
    attempts++;
  }

  if (fs.existsSync(tempPng)) {
    fs.copyFileSync(tempPng, finalOutputPath);
    try { fs.unlinkSync(tempPng); } catch (e) {}
    try { fs.unlinkSync(tempHtml); } catch (e) {}
    console.log(`✓ Generated: ${path.relative(WORKSPACE_DIR, finalOutputPath)} (${width}x${height})`);
    return true;
  } else {
    console.error(`✗ Failed to generate: ${finalOutputPath}`);
    return false;
  }
}

// Global styles for all mockups
const baseHead = `
<head>
<meta charset="utf-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&family=JetBrains+Mono:wght@500;700&display=swap" rel="stylesheet">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, sans-serif;
    color: #FFFFFF;
    background-color: #090D16;
    background-image: 
      radial-gradient(circle at 15% 20%, rgba(234, 88, 12, 0.18) 0%, transparent 40%),
      radial-gradient(circle at 85% 80%, rgba(212, 175, 55, 0.14) 0%, transparent 40%),
      radial-gradient(circle at 50% 50%, rgba(30, 41, 59, 0.5) 0%, transparent 70%);
    overflow: hidden;
  }

  /* Phone Mockup Styling */
  .phone-chassis {
    width: 320px;
    height: 650px;
    background: #1C1917;
    border-radius: 44px;
    border: 9px solid #2B2A2E;
    box-shadow: 
      0 0 0 1px rgba(255, 255, 255, 0.12),
      0 35px 70px -15px rgba(0, 0, 0, 0.8),
      0 15px 30px rgba(0, 0, 0, 0.5);
    position: relative;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    flex-shrink: 0;
  }

  .phone-screen {
    width: 100%;
    height: 100%;
    background: #FAF8F5;
    color: #1C1917;
    display: flex;
    flex-direction: column;
    overflow: hidden;
    position: relative;
  }

  .phone-screen.dark-theme {
    background: #151312;
    color: #F8FAFC;
  }

  .phone-notch {
    position: absolute;
    top: 8px;
    left: 50%;
    transform: translateX(-50%);
    width: 85px;
    height: 22px;
    background: #000000;
    border-radius: 14px;
    z-index: 100;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    padding-right: 8px;
  }

  .phone-camera-lens {
    width: 9px;
    height: 9px;
    border-radius: 50%;
    background: #1A1A24;
    border: 1px solid rgba(255, 255, 255, 0.15);
  }

  .status-bar {
    height: 38px;
    padding: 10px 18px 0 18px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 11px;
    font-weight: 700;
    z-index: 90;
    color: inherit;
  }

  .status-icons {
    display: flex;
    gap: 5px;
    align-items: center;
    font-size: 10px;
  }

  /* Badge Pills */
  .badge-category {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: rgba(234, 88, 12, 0.15);
    border: 1px solid rgba(234, 88, 12, 0.35);
    color: #FF8A4C;
    padding: 6px 14px;
    border-radius: 30px;
    font-size: 12px;
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 1.2px;
  }

  .badge-category.instructor {
    background: rgba(212, 175, 55, 0.15);
    border-color: rgba(212, 175, 55, 0.4);
    color: #FBBF24;
  }

  .feature-chip {
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    padding: 12px 18px;
    display: flex;
    align-items: center;
    gap: 12px;
    color: #E2E8F0;
    font-size: 14px;
    font-weight: 600;
    backdrop-filter: blur(10px);
  }

  .feature-chip-icon {
    width: 32px;
    height: 32px;
    border-radius: 8px;
    background: linear-gradient(135deg, #EA580C, #F97316);
    display: flex;
    align-items: center;
    justify-content: center;
    color: #FFF;
    font-size: 15px;
    flex-shrink: 0;
  }

  .feature-chip-icon.gold {
    background: linear-gradient(135deg, #D4AF37, #F59E0B);
  }
</style>
</head>
`;

module.exports = {
  renderScreenshot,
  baseHead,
  logoSrc,
  dirIcon,
  dirCover,
  dirGallery
};
