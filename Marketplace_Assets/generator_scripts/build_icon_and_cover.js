const path = require('path');
const { renderScreenshot, baseHead, logoSrc, dirIcon, dirCover } = require('./build_assets_base');

// 1. Icon 200x200
const icon200Html = `
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 200px;
    height: 200px;
    overflow: hidden;
    background: transparent;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Segoe UI', -apple-system, sans-serif;
  }
  .icon-canvas {
    width: 200px;
    height: 200px;
    background: linear-gradient(135deg, #1C1917 0%, #0F172A 100%);
    border-radius: 46px;
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    box-shadow: inset 0 0 0 2px rgba(255, 255, 255, 0.15);
  }
  .glow-ring {
    position: absolute;
    width: 140px;
    height: 140px;
    border-radius: 50%;
    background: radial-gradient(circle, rgba(234, 88, 12, 0.7) 0%, transparent 70%);
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }
  .brand-logo {
    width: 105px;
    height: 105px;
    border-radius: 28px;
    background: linear-gradient(135deg, #EA580C 0%, #F97316 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 12px 24px rgba(234, 88, 12, 0.5), inset 0 1px 1px rgba(255, 255, 255, 0.4);
    z-index: 10;
  }
  .brand-logo span {
    font-size: 64px;
    font-weight: 900;
    color: #FFFFFF;
    letter-spacing: -2px;
    transform: translateY(-2px);
  }
  .mini-badge {
    position: absolute;
    bottom: 12px;
    background: rgba(255, 255, 255, 0.12);
    border: 1px solid rgba(255, 255, 255, 0.2);
    padding: 3px 10px;
    border-radius: 10px;
    font-size: 10px;
    font-weight: 800;
    color: #FFEDD5;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    z-index: 10;
  }
</style>
</head>
<body>
  <div class="icon-canvas">
    <div class="glow-ring"></div>
    <div class="brand-logo">
      <span>S</span>
    </div>
    <div class="mini-badge">2-IN-1 LMS</div>
  </div>
</body>
</html>
`;

// 2. Icon 80x80 (for CodeCanyon)
const icon80Html = `
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    width: 80px;
    height: 80px;
    overflow: hidden;
    background: transparent;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: sans-serif;
  }
  .icon-canvas {
    width: 80px;
    height: 80px;
    background: linear-gradient(135deg, #1C1917 0%, #0F172A 100%);
    border-radius: 18px;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    box-shadow: inset 0 0 0 1px rgba(255, 255, 255, 0.2);
  }
  .brand-logo {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    background: linear-gradient(135deg, #EA580C 0%, #F97316 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 10px rgba(234, 88, 12, 0.45);
  }
  .brand-logo span {
    font-size: 28px;
    font-weight: 900;
    color: #FFFFFF;
    transform: translateY(-1px);
  }
</style>
</head>
<body>
  <div class="icon-canvas">
    <div class="brand-logo">
      <span>S</span>
    </div>
  </div>
</body>
</html>
`;

// 3. Cover 1200x800 (Codester & CodeCanyon Main Cover)
const cover1200Html = `
<!DOCTYPE html>
<html>
${baseHead}
<body style="width: 1200px; height: 800px; display: flex; flex-direction: column; justify-content: space-between; padding: 40px 60px;">

  <!-- Header -->
  <div style="display: flex; justify-content: space-between; align-items: center; z-index: 10;">
    <div style="display: flex; align-items: center; gap: 16px;">
      <div style="width: 48px; height: 48px; border-radius: 14px; background: linear-gradient(135deg, #EA580C, #F97316); display: flex; align-items: center; justify-content: center; font-size: 26px; font-weight: 900; color: #FFF; box-shadow: 0 8px 20px rgba(234, 88, 12, 0.4);">S</div>
      <div>
        <h2 style="font-size: 24px; font-weight: 800; letter-spacing: -0.5px; color: #FFFFFF;">Skillora LMS</h2>
        <span style="font-size: 12px; font-weight: 700; color: #EA580C; letter-spacing: 1.5px; text-transform: uppercase;">2-in-1 Complete Flutter Suite</span>
      </div>
    </div>

    <!-- Tech Badges -->
    <div style="display: flex; gap: 10px;">
      <span style="background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.12); padding: 8px 16px; border-radius: 20px; font-size: 13px; font-weight: 700; color: #E2E8F0;">Flutter 3.24+</span>
      <span style="background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.12); padding: 8px 16px; border-radius: 20px; font-size: 13px; font-weight: 700; color: #E2E8F0;">GetX Architecture</span>
      <span style="background: rgba(234,88,12,0.15); border: 1px solid rgba(234,88,12,0.3); padding: 8px 16px; border-radius: 20px; font-size: 13px; font-weight: 800; color: #FF8A4C;">2 Complete Apps</span>
    </div>
  </div>

  <!-- Center Presentation: Left Hero Text + Right Dual Phones -->
  <div style="display: flex; align-items: center; justify-content: space-between; z-index: 10; margin-top: 10px;">
    
    <!-- Left Column: Copy & Highlights -->
    <div style="max-width: 480px;">
      <div style="display: inline-flex; align-items: center; gap: 8px; background: rgba(212, 175, 55, 0.15); border: 1px solid rgba(212, 175, 55, 0.35); padding: 6px 14px; border-radius: 30px; margin-bottom: 20px;">
        <span style="color: #FBBF24; font-size: 13px;">★</span>
        <span style="font-size: 12px; font-weight: 800; color: #FDE68A; text-transform: uppercase; letter-spacing: 1.2px;">Commercial Ready &bull; Zero Warnings</span>
      </div>

      <h1 style="font-size: 44px; font-weight: 900; line-height: 1.15; letter-spacing: -1px; margin-bottom: 18px; color: #FFFFFF;">
        The Ultimate <br/>
        <span style="background: linear-gradient(135deg, #EA580C 0%, #FBBF24 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Dual-Role Flutter LMS</span>
      </h1>

      <p style="font-size: 16px; line-height: 1.6; color: #94A3B8; margin-bottom: 28px;">
        Student Learning App + Dedicated Instructor Studio. Featuring live video lectures, interactive Q&A, lesson checklists, verifiable certificates, and wallet payouts.
      </p>

      <!-- 4 Highlight Chips -->
      <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px;">
        <div class="feature-chip" style="padding: 10px 14px; font-size: 13px;">
          <div class="feature-chip-icon" style="width: 28px; height: 28px; font-size: 13px;">📱</div>
          <span>Student App</span>
        </div>
        <div class="feature-chip" style="padding: 10px 14px; font-size: 13px;">
          <div class="feature-chip-icon gold" style="width: 28px; height: 28px; font-size: 13px;">👨‍🏫</div>
          <span>Instructor Studio</span>
        </div>
        <div class="feature-chip" style="padding: 10px 14px; font-size: 13px;">
          <div class="feature-chip-icon gold" style="width: 28px; height: 28px; font-size: 13px;">🎓</div>
          <span>Verifiable Certificate</span>
        </div>
        <div class="feature-chip" style="padding: 10px 14px; font-size: 13px;">
          <div class="feature-chip-icon" style="width: 28px; height: 28px; font-size: 13px;">💳</div>
          <span>Stripe Integration</span>
        </div>
      </div>
    </div>

    <!-- Right Column: Dual Phones (Student Left, Instructor Right) -->
    <div style="position: relative; width: 560px; height: 560px; display: flex; align-items: center; justify-content: center;">
      
      <!-- Student Phone (Tilted Left) -->
      <div class="phone-chassis" style="position: absolute; left: 20px; top: 15px; transform: scale(0.78) rotate(-4deg); z-index: 5;">
        <div class="phone-notch"><div class="phone-camera-lens"></div></div>
        <div class="phone-screen">
          <div class="status-bar"><span>9:41</span><div class="status-icons"><span>5G</span><span>100%</span></div></div>
          
          <!-- App Header -->
          <div style="padding: 12px 16px; background: #FFF; border-bottom: 1px solid #E2E8F0; display: flex; justify-content: space-between; align-items: center;">
            <div style="display: flex; align-items: center; gap: 10px;">
              <div style="width: 32px; height: 32px; border-radius: 50%; background: #EA580C; color: #FFF; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 13px;">AM</div>
              <div>
                <div style="font-size: 10px; color: #64748B;">Welcome back,</div>
                <div style="font-size: 13px; font-weight: 800;">Alex Morgan</div>
              </div>
            </div>
            <div style="width: 28px; height: 28px; border-radius: 50%; background: #F1F5F9; display: flex; align-items: center; justify-content: center; font-size: 13px;">🔔</div>
          </div>

          <!-- Video Card -->
          <div style="margin: 12px 16px; background: #0F172A; border-radius: 16px; overflow: hidden; color: #FFF; box-shadow: 0 8px 16px rgba(0,0,0,0.15);">
            <div style="height: 120px; background: linear-gradient(135deg, #1E293B, #0F172A); display: flex; align-items: center; justify-content: center; position: relative;">
              <div style="width: 44px; height: 44px; border-radius: 50%; background: #EA580C; display: flex; align-items: center; justify-content: center; font-size: 18px; box-shadow: 0 4px 12px rgba(234,88,12,0.6);">▶</div>
              <span style="position: absolute; bottom: 8px; right: 10px; background: rgba(0,0,0,0.6); padding: 2px 6px; border-radius: 4px; font-size: 10px;">24:15</span>
            </div>
            <div style="padding: 12px;">
              <div style="font-size: 13px; font-weight: 800; margin-bottom: 4px;">Flutter & GetX Masterclass</div>
              <div style="font-size: 11px; color: #94A3B8;">Michael Chen &bull; 85% Complete</div>
              <div style="margin-top: 8px; height: 5px; background: #334155; border-radius: 3px; overflow: hidden;">
                <div style="width: 85%; height: 100%; background: #EA580C;"></div>
              </div>
            </div>
          </div>

          <!-- Lesson Checklist Card -->
          <div style="margin: 0 16px; background: #FFF; border-radius: 14px; padding: 12px; border: 1px solid #E2E8F0;">
            <div style="font-size: 12px; font-weight: 800; margin-bottom: 8px;">Curriculum & Checklists</div>
            <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 6px; font-size: 11px;">
              <span style="color: #10B981; font-weight: 900;">✓</span>
              <span style="text-decoration: line-through; color: #94A3B8;">1. State Management Basics</span>
            </div>
            <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 6px; font-size: 11px;">
              <span style="color: #10B981; font-weight: 900;">✓</span>
              <span style="text-decoration: line-through; color: #94A3B8;">2. Reactive GetX Controllers</span>
            </div>
            <div style="display: flex; align-items: center; gap: 8px; font-size: 11px;">
              <span style="color: #EA580C; font-weight: 900;">▶</span>
              <span style="font-weight: 700; color: #0F172A;">3. Stripe Payment Gateway</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Instructor Phone (Tilted Right, In Front) -->
      <div class="phone-chassis" style="position: absolute; right: 10px; top: -5px; transform: scale(0.82) rotate(3deg); z-index: 10;">
        <div class="phone-notch"><div class="phone-camera-lens"></div></div>
        <div class="phone-screen dark-theme">
          <div class="status-bar"><span>9:41</span><div class="status-icons"><span>5G</span><span>100%</span></div></div>
          
          <!-- Instructor Header -->
          <div style="padding: 12px 16px; background: #1C1917; border-bottom: 1px solid #2B2A2E; display: flex; justify-content: space-between; align-items: center;">
            <div style="display: flex; align-items: center; gap: 10px;">
              <div style="width: 32px; height: 32px; border-radius: 50%; background: linear-gradient(135deg, #D4AF37, #F59E0B); color: #000; display: flex; align-items: center; justify-content: center; font-weight: 900; font-size: 13px;">MC</div>
              <div>
                <div style="font-size: 10px; color: #D4AF37; font-weight: 700; text-transform: uppercase;">Instructor Studio</div>
                <div style="font-size: 13px; font-weight: 800; color: #FFF;">Michael Chen</div>
              </div>
            </div>
            <span style="background: rgba(16, 185, 129, 0.2); color: #10B981; font-size: 10px; font-weight: 800; padding: 4px 8px; border-radius: 6px;">● ONLINE</span>
          </div>

          <!-- Revenue Card -->
          <div style="margin: 12px 16px; background: linear-gradient(135deg, #2A2521, #1C1917); border: 1px solid rgba(212, 175, 55, 0.3); border-radius: 16px; padding: 14px;">
            <div style="font-size: 11px; color: #A8A29E; margin-bottom: 2px;">Total Earnings</div>
            <div style="font-size: 26px; font-weight: 900; color: #FBBF24; letter-spacing: -0.5px;">$14,850.00</div>
            <div style="display: flex; justify-content: space-between; margin-top: 10px; padding-top: 10px; border-top: 1px solid rgba(255,255,255,0.08); font-size: 11px;">
              <span>Students: <strong>22,100</strong></span>
              <span style="color: #10B981;">+18.4% this mo</span>
            </div>
          </div>

          <!-- Quick Action Buttons -->
          <div style="margin: 0 16px 12px 16px; display: grid; grid-template-columns: 1fr 1fr; gap: 8px;">
            <div style="background: #23201D; border-radius: 10px; padding: 10px; text-align: center; border: 1px solid rgba(255,255,255,0.05);">
              <div style="font-size: 16px; margin-bottom: 2px;">💬</div>
              <div style="font-size: 11px; font-weight: 700; color: #E7E5E4;">Q&A Hub (12)</div>
            </div>
            <div style="background: #23201D; border-radius: 10px; padding: 10px; text-align: center; border: 1px solid rgba(255,255,255,0.05);">
              <div style="font-size: 16px; margin-bottom: 2px;">✍</div>
              <div style="font-size: 11px; font-weight: 700; color: #E7E5E4;">Signatures</div>
            </div>
          </div>

          <!-- Payout Notice -->
          <div style="margin: 0 16px; background: rgba(16, 185, 129, 0.1); border: 1px solid rgba(16, 185, 129, 0.3); border-radius: 10px; padding: 10px; display: flex; align-items: center; gap: 10px;">
            <span style="font-size: 16px;">💰</span>
            <div>
              <div style="font-size: 11px; font-weight: 800; color: #10B981;">Payout Requested: $3,200</div>
              <div style="font-size: 9.5px; color: #94A3B8;">Processing via Bank Transfer</div>
            </div>
          </div>
        </div>
      </div>

    </div>

  </div>

  <!-- Footer Banner -->
  <div style="display: flex; justify-content: space-between; align-items: center; padding-top: 16px; border-top: 1px solid rgba(255, 255, 255, 0.08); z-index: 10;">
    <div style="font-size: 13px; color: #64748B;">
      Built with clean Flutter code &bull; Fully White-label &bull; Interactive HTML Documentation
    </div>
    <div style="font-size: 13px; font-weight: 700; color: #F59E0B;">
      ★ Rated 5.0 for Mobile LMS &amp; Ed-Tech
    </div>
  </div>

</body>
</html>
`;

// 4. Preview 590x300 (for CodeCanyon Inline Preview)
const preview590Html = `
<!DOCTYPE html>
<html>
${baseHead}
<body style="width: 590px; height: 300px; display: flex; align-items: center; justify-content: space-between; padding: 24px 32px; background: #0A0D14;">

  <!-- Left Content -->
  <div style="max-width: 280px; z-index: 10;">
    <div style="display: inline-flex; align-items: center; gap: 6px; background: rgba(234, 88, 12, 0.15); border: 1px solid rgba(234, 88, 12, 0.3); padding: 3px 8px; border-radius: 20px; margin-bottom: 8px;">
      <span style="font-size: 9px; font-weight: 800; color: #FF8A4C; letter-spacing: 1px;">2-IN-1 FLUTTER LMS</span>
    </div>
    <h1 style="font-size: 24px; font-weight: 900; line-height: 1.15; margin-bottom: 8px; color: #FFF;">
      Skillora LMS Suite
    </h1>
    <p style="font-size: 11px; line-height: 1.4; color: #94A3B8; margin-bottom: 14px;">
      Student App + Instructor Studio. Video courses, Q&A community, and verifiable certificates.
    </p>
    <div style="display: flex; gap: 6px;">
      <span style="background: rgba(255,255,255,0.08); padding: 4px 8px; border-radius: 6px; font-size: 10px; font-weight: 700;">Flutter 3.24+</span>
      <span style="background: rgba(255,255,255,0.08); padding: 4px 8px; border-radius: 6px; font-size: 10px; font-weight: 700;">GetX</span>
      <span style="background: rgba(212,175,55,0.15); color: #FBBF24; padding: 4px 8px; border-radius: 6px; font-size: 10px; font-weight: 800;">2 Apps</span>
    </div>
  </div>

  <!-- Right Visual: Mini Phones -->
  <div style="position: relative; width: 230px; height: 260px; display: flex; align-items: center; justify-content: center;">
    
    <!-- Student Phone -->
    <div class="phone-chassis" style="position: absolute; left: 0px; top: 10px; transform: scale(0.38); transform-origin: top left; z-index: 5;">
      <div class="phone-notch"><div class="phone-camera-lens"></div></div>
      <div class="phone-screen">
        <div class="status-bar"><span>9:41</span><div class="status-icons"><span>5G</span></div></div>
        <div style="padding: 16px; background: #FFF;">
          <div style="font-size: 16px; font-weight: 800; color: #EA580C;">Student App</div>
          <div style="height: 120px; background: #0F172A; border-radius: 12px; margin: 12px 0; display: flex; align-items: center; justify-content: center; color: white; font-size: 30px;">▶</div>
          <div style="font-size: 14px; font-weight: 800;">Course Checklist</div>
          <div style="font-size: 12px; color: #10B981; margin-top: 6px;">✓ 100% Certificate Ready</div>
        </div>
      </div>
    </div>

    <!-- Instructor Phone -->
    <div class="phone-chassis" style="position: absolute; left: 75px; top: -5px; transform: scale(0.40); transform-origin: top left; z-index: 10;">
      <div class="phone-notch"><div class="phone-camera-lens"></div></div>
      <div class="phone-screen dark-theme">
        <div class="status-bar"><span>9:41</span><div class="status-icons"><span>5G</span></div></div>
        <div style="padding: 16px; background: #1C1917;">
          <div style="font-size: 16px; font-weight: 800; color: #D4AF37;">Instructor Studio</div>
          <div style="background: #2A2521; border-radius: 12px; padding: 14px; margin: 12px 0; border: 1px solid rgba(212,175,55,0.4);">
            <div style="font-size: 12px; color: #A8A29E;">Total Revenue</div>
            <div style="font-size: 26px; font-weight: 900; color: #FBBF24;">$14,850</div>
          </div>
          <div style="font-size: 13px; font-weight: 800; color: #10B981;">Payout Approved</div>
        </div>
      </div>
    </div>

  </div>

</body>
</html>
`;

// Render All
console.log("Starting Icon & Cover generation...");
renderScreenshot(icon200Html, 200, 200, path.join(dirIcon, "icon_200x200.png"));
renderScreenshot(icon80Html, 80, 80, path.join(dirIcon, "icon_80x80.png"));
renderScreenshot(cover1200Html, 1200, 800, path.join(dirCover, "cover_1200x800.png"));
renderScreenshot(preview590Html, 590, 300, path.join(dirCover, "preview_590x300.png"));
console.log("Icon & Cover generation complete.");
