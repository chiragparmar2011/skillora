const path = require('path');
const { renderScreenshot, baseHead, dirGallery } = require('./build_assets_base');

// Helper to wrap a gallery slide
function createSlideHtml({
  category = "STUDENT LEARNING APP",
  isInstructor = false,
  badgeText = "VERIFIED LMS FEATURE",
  headline = "Feature Title",
  subheadline = "Detailed explanation of this feature.",
  chips = [],
  phoneTheme = "light",
  phoneContentHtml = ""
}) {
  const isDark = phoneTheme === "dark";
  return `
<!DOCTYPE html>
<html>
${baseHead}
<body style="width: 1200px; height: 800px; display: flex; align-items: center; justify-content: space-between; padding: 50px 75px; position: relative;">

  <!-- Left Info Column -->
  <div style="max-width: 530px; z-index: 10;">
    
    <!-- Top Pill -->
    <div style="margin-bottom: 20px;">
      <span class="badge-category ${isInstructor ? 'instructor' : ''}">
        ${category}
      </span>
    </div>

    <!-- Main Headline -->
    <h1 style="font-size: 42px; font-weight: 900; line-height: 1.15; letter-spacing: -1px; margin-bottom: 18px; color: #FFFFFF;">
      ${headline}
    </h1>

    <!-- Subtitle -->
    <p style="font-size: 16px; line-height: 1.6; color: #94A3B8; margin-bottom: 32px;">
      ${subheadline}
    </p>

    <!-- Feature Chips -->
    <div style="display: flex; flex-direction: column; gap: 12px;">
      ${chips.map(chip => `
        <div class="feature-chip">
          <div class="feature-chip-icon ${isInstructor ? 'gold' : ''}">
            ${chip.icon || '✓'}
          </div>
          <div>
            <div style="font-weight: 700; color: #F8FAFC;">${chip.title}</div>
            <div style="font-size: 12.5px; color: #94A3B8; margin-top: 2px;">${chip.desc}</div>
          </div>
        </div>
      `).join('')}
    </div>

  </div>

  <!-- Right Phone Column -->
  <div style="z-index: 10; display: flex; align-items: center; justify-content: center; width: 440px;">
    <div class="phone-chassis">
      <div class="phone-notch"><div class="phone-camera-lens"></div></div>
      <div class="phone-screen ${isDark ? 'dark-theme' : ''}">
        
        <!-- Status Bar -->
        <div class="status-bar">
          <span>9:41</span>
          <div class="status-icons">
            <span>5G</span>
            <span>100%</span>
          </div>
        </div>

        <!-- Phone Dynamic Content -->
        ${phoneContentHtml}

      </div>
    </div>
  </div>

  <!-- Slide Footer Watermark -->
  <div style="position: absolute; bottom: 24px; left: 75px; right: 75px; display: flex; justify-content: space-between; align-items: center; font-size: 12px; color: #475569; z-index: 10; border-top: 1px solid rgba(255,255,255,0.06); padding-top: 12px;">
    <div><strong>Skillora LMS Suite</strong> &bull; Complete Flutter Commercial Package</div>
    <div>100% Standalone &bull; GetX Architecture</div>
  </div>

</body>
</html>
  `;
}

// 16 SLIDE DEFINITIONS
const slides = [
  // SLIDE 1: Hero Ecosystem
  {
    fileName: "01_hero_ecosystem.png",
    category: "ENTERPRISE FLUTTER LMS",
    isInstructor: false,
    headline: "2-in-1 Dual Application Ecosystem",
    subheadline: "A unified Ed-Tech suite featuring both a Student Learning App and an Instructor Studio App, working in complete harmony.",
    chips: [
      { icon: "📱", title: "Student Learning App", desc: "Interactive lectures, checklists, Q&A, and digital certificates." },
      { icon: "👨‍🏫", title: "Instructor Studio App", desc: "Curriculum builder, revenue analytics, and Q&A management." },
      { icon: "⚡", title: "Clean Modular Code", desc: "GetX state management, 0 compile errors, zero warnings." }
    ],
    phoneTheme: "light",
    phoneContentHtml: `
      <div style="padding: 16px; background: #FFF; border-bottom: 1px solid #E2E8F0;">
        <div style="display: flex; align-items: center; gap: 8px;">
          <div style="width: 28px; height: 28px; border-radius: 8px; background: #EA580C; color: #FFF; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 14px;">S</div>
          <div style="font-weight: 800; font-size: 15px; color: #0F172A;">Skillora LMS</div>
        </div>
      </div>
      <div style="padding: 16px;">
        <div style="background: linear-gradient(135deg, #EA580C, #F97316); border-radius: 16px; padding: 18px; color: #FFF; margin-bottom: 14px; box-shadow: 0 10px 20px rgba(234,88,12,0.3);">
          <div style="font-size: 11px; text-transform: uppercase; letter-spacing: 1px; font-weight: 700; opacity: 0.9;">Student App</div>
          <div style="font-size: 18px; font-weight: 900; margin: 4px 0;">Start Learning Today</div>
          <div style="font-size: 11px; opacity: 0.95;">1,200+ Courses across 15 Categories</div>
        </div>
        <div style="background: #1C1917; border-radius: 16px; padding: 18px; color: #FFF; border: 1px solid rgba(212,175,55,0.4); box-shadow: 0 10px 20px rgba(0,0,0,0.25);">
          <div style="font-size: 11px; text-transform: uppercase; letter-spacing: 1px; font-weight: 700; color: #D4AF37;">Instructor Studio</div>
          <div style="font-size: 18px; font-weight: 900; margin: 4px 0;">Educator Dashboard</div>
          <div style="font-size: 11px; color: #A8A29E;">Manage Curriculum, Live Q&A & Payouts</div>
        </div>
      </div>
    `
  },

  // SLIDE 2: Onboarding & Authentication
  {
    fileName: "02_onboarding_welcome.png",
    category: "STUDENT APP",
    isInstructor: false,
    headline: "Sleek Onboarding & Authentication",
    subheadline: "Welcoming multi-slide carousel, phone OTP verification with Pinput, and Google & Apple sign-in options.",
    chips: [
      { icon: "✨", title: "Modern Onboarding Slides", desc: "High-resolution illustrations and smooth paging transitions." },
      { icon: "🔒", title: "OTP Phone Authentication", desc: "Interactive 6-digit pin code entry with auto-focus." },
      { icon: "⚡", title: "Guest Mode & Quick Login", desc: "One-tap guest exploration or demo credentials auto-fill." }
    ],
    phoneTheme: "light",
    phoneContentHtml: `
      <div style="flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 24px; text-align: center;">
        <div style="width: 140px; height: 140px; border-radius: 50%; background: #FFF7ED; display: flex; align-items: center; justify-content: center; font-size: 60px; margin-bottom: 24px; box-shadow: 0 10px 25px rgba(234,88,12,0.15);">
          🎓
        </div>
        <div style="font-size: 20px; font-weight: 900; color: #0F172A; margin-bottom: 8px;">Learn from Top Mentors</div>
        <div style="font-size: 12.5px; color: #64748B; line-height: 1.5; margin-bottom: 24px;">
          Access structured video courses, ask doubts in real-time, and earn certified degrees.
        </div>
        <div style="display: flex; gap: 6px; margin-bottom: 24px;">
          <span style="width: 24px; height: 6px; border-radius: 3px; background: #EA580C;"></span>
          <span style="width: 8px; height: 6px; border-radius: 3px; background: #E2E8F0;"></span>
          <span style="width: 8px; height: 6px; border-radius: 3px; background: #E2E8F0;"></span>
        </div>
        <button style="width: 100%; height: 46px; background: #EA580C; border: none; border-radius: 12px; color: #FFF; font-weight: 800; font-size: 14px; box-shadow: 0 8px 16px rgba(234,88,12,0.35);">
          Get Started
        </button>
      </div>
    `
  },

  // SLIDE 3: Course Catalog & Discovery
  {
    fileName: "03_student_course_catalog.png",
    category: "STUDENT APP",
    isInstructor: false,
    headline: "Course Discovery & Category Filters",
    subheadline: "Smart search, horizontal category carousels, trending course badges, and bookmarking.",
    chips: [
      { icon: "🔍", title: "Smart Instant Search", desc: "Real-time autocomplete and recent search query caching." },
      { icon: "🏷️", title: "Categorized Tracks", desc: "UI/UX Design, Flutter, Full-Stack, AI & Machine Learning." },
      { icon: "🔥", title: "Trending & Popular", desc: "Dynamic badges for bestsellers, ratings, and student counts." }
    ],
    phoneTheme: "light",
    phoneContentHtml: `
      <div style="padding: 12px 16px; background: #FFF;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
          <div>
            <div style="font-size: 11px; color: #64748B;">Explore Catalog</div>
            <div style="font-size: 16px; font-weight: 800; color: #0F172A;">Find Your Course</div>
          </div>
          <div style="width: 32px; height: 32px; border-radius: 50%; background: #FFF7ED; color: #EA580C; display: flex; align-items: center; justify-content: center; font-size: 14px;">🔍</div>
        </div>
        <div style="display: flex; gap: 8px; overflow-x: hidden; margin-bottom: 12px;">
          <span style="background: #EA580C; color: #FFF; padding: 6px 14px; border-radius: 20px; font-size: 11px; font-weight: 700;">All</span>
          <span style="background: #F1F5F9; color: #475569; padding: 6px 12px; border-radius: 20px; font-size: 11px; font-weight: 600;">Flutter</span>
          <span style="background: #F1F5F9; color: #475569; padding: 6px 12px; border-radius: 20px; font-size: 11px; font-weight: 600;">UI/UX</span>
          <span style="background: #F1F5F9; color: #475569; padding: 6px 12px; border-radius: 20px; font-size: 11px; font-weight: 600;">Python</span>
        </div>
      </div>
      <div style="padding: 0 16px; margin-top: 8px;">
        <div style="background: #FFF; border-radius: 14px; border: 1px solid #E2E8F0; overflow: hidden; margin-bottom: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.04);">
          <div style="height: 100px; background: linear-gradient(135deg, #1E293B, #0F172A); display: flex; align-items: center; justify-content: center; color: #FFF; position: relative;">
            <div style="font-size: 32px;">📱</div>
            <span style="position: absolute; top: 8px; left: 8px; background: #EA580C; color: #FFF; font-size: 9px; font-weight: 800; padding: 3px 6px; border-radius: 4px;">BESTSELLER</span>
          </div>
          <div style="padding: 10px 12px;">
            <div style="font-size: 13px; font-weight: 800; color: #0F172A;">Flutter 3 & GetX Masterclass</div>
            <div style="font-size: 11px; color: #64748B; margin: 2px 0;">Michael Chen &bull; 4.9 ★ (2,410)</div>
            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 6px;">
              <span style="font-size: 14px; font-weight: 900; color: #EA580C;">$49.99</span>
              <span style="font-size: 10px; color: #94A3B8;">38 Lessons &bull; 14h</span>
            </div>
          </div>
        </div>
      </div>
    `
  },

  // SLIDE 4: Course Details & Curriculum
  {
    fileName: "04_course_details_syllabus.png",
    category: "STUDENT APP",
    isInstructor: false,
    headline: "Course Details & Curriculum Breakdown",
    subheadline: "Deep dive into course metadata, instructor credentials, module sections, and lecture preview status.",
    chips: [
      { icon: "📋", title: "Comprehensive Syllabus", desc: "Structured modules with lesson counts and total durations." },
      { icon: "👁️", title: "Free Preview Video", desc: "Allow students to sample lectures before purchasing." },
      { icon: "👨‍🏫", title: "Mentor Summary", desc: "Instructor bio, total learners, and average course rating." }
    ],
    phoneTheme: "light",
    phoneContentHtml: `
      <div style="height: 130px; background: #0F172A; display: flex; align-items: center; justify-content: center; position: relative; color: #FFF;">
        <div style="width: 44px; height: 44px; border-radius: 50%; background: #EA580C; display: flex; align-items: center; justify-content: center; font-size: 18px;">▶</div>
        <span style="position: absolute; bottom: 8px; left: 12px; background: rgba(0,0,0,0.6); padding: 2px 8px; border-radius: 4px; font-size: 10px;">Free Preview</span>
      </div>
      <div style="padding: 14px 16px; background: #FFF; flex: 1;">
        <div style="font-size: 16px; font-weight: 900; color: #0F172A; margin-bottom: 4px;">UI/UX Design Masterclass</div>
        <div style="font-size: 11.5px; color: #64748B; margin-bottom: 12px;">By Sarah Jenkins &bull; Lead UI/UX Designer</div>
        <div style="display: flex; gap: 8px; border-bottom: 2px solid #F1F5F9; padding-bottom: 8px; margin-bottom: 12px;">
          <span style="font-size: 12px; font-weight: 800; color: #EA580C; border-bottom: 2px solid #EA580C; padding-bottom: 6px; margin-bottom: -10px;">Curriculum</span>
          <span style="font-size: 12px; font-weight: 600; color: #64748B;">Overview</span>
          <span style="font-size: 12px; font-weight: 600; color: #64748B;">Reviews (4.9)</span>
        </div>
        <div style="background: #F8FAFC; border: 1px solid #E2E8F0; border-radius: 10px; padding: 10px; margin-bottom: 8px;">
          <div style="font-size: 11px; font-weight: 800; color: #0F172A;">Module 1: Figma Essentials</div>
          <div style="font-size: 10px; color: #64748B; margin-top: 2px;">4 Lessons &bull; 45 mins</div>
        </div>
        <div style="background: #F8FAFC; border: 1px solid #E2E8F0; border-radius: 10px; padding: 10px;">
          <div style="font-size: 11px; font-weight: 800; color: #0F172A;">Module 2: Design Systems & Tokens</div>
          <div style="font-size: 10px; color: #64748B; margin-top: 2px;">6 Lessons &bull; 1h 20m</div>
        </div>
      </div>
    `
  },

  // SLIDE 5: Video Player & Lecture Viewer
  {
    fileName: "05_video_learning_player.png",
    category: "STUDENT APP",
    isInstructor: false,
    headline: "High-Definition Video Lecture Player",
    subheadline: "Robust video streaming with playback speed control (1.0x, 1.5x, 2.0x), landscape orientation, and lesson jumping.",
    chips: [
      { icon: "▶️", title: "Native Video Streaming", desc: "Powered by video_player & pod_player with seamless buffering." },
      { icon: "⏩", title: "Playback Speed Tuning", desc: "Accelerate or decelerate lectures according to student preference." },
      { icon: "📱", title: "Fullscreen Landscape Mode", desc: "One-tap orientation lock for immersive distraction-free viewing." }
    ],
    phoneTheme: "light",
    phoneContentHtml: `
      <div style="height: 180px; background: #000; position: relative; display: flex; flex-direction: column; justify-content: space-between; padding: 12px; color: #FFF;">
        <div style="display: flex; justify-content: space-between; font-size: 12px;">
          <span>Lesson 4 of 38</span>
          <span style="background: rgba(255,255,255,0.2); padding: 2px 6px; border-radius: 4px;">1080p HD</span>
        </div>
        <div style="align-self: center; width: 44px; height: 44px; border-radius: 50%; background: rgba(234,88,12,0.9); display: flex; align-items: center; justify-content: center; font-size: 18px;">
          ❚❚
        </div>
        <div>
          <div style="height: 4px; background: rgba(255,255,255,0.3); border-radius: 2px; margin-bottom: 6px; position: relative;">
            <div style="width: 45%; height: 100%; background: #EA580C; border-radius: 2px;"></div>
          </div>
          <div style="display: flex; justify-content: space-between; font-size: 10px; color: #94A3B8;">
            <span>12:40 / 28:15</span>
            <span>Speed: 1.5x</span>
          </div>
        </div>
      </div>
      <div style="padding: 14px 16px; background: #FFF; flex: 1;">
        <div style="font-size: 15px; font-weight: 800; color: #0F172A;">4. Implementing GetX State Controller</div>
        <div style="font-size: 11px; color: #64748B; margin: 4px 0 12px 0;">Flutter & GetX Masterclass &bull; Michael Chen</div>
        <div style="background: #FFF7ED; border-left: 3px solid #EA580C; padding: 8px 12px; border-radius: 4px; font-size: 11px; color: #9A3412;">
          💡 Tip: Pay close attention to the reactive .obs listener variables explained at 14:20.
        </div>
      </div>
    `
  },

  // SLIDE 6: Lesson Progress & Checklist
  {
    fileName: "06_lesson_progress_checklist.png",
    category: "STUDENT APP",
    isInstructor: false,
    headline: "Interactive Lesson Progress & Checklist",
    subheadline: "Every course features dynamic lesson checkboxes that automatically recalculate completion percentage and unlock certificates.",
    chips: [
      { icon: "☑️", title: "Instant Checkmark Toggles", desc: "Tap to complete lessons with immediate UI feedback." },
      { icon: "📊", title: "Live Progress Recalculation", desc: "Percentage bar recalculates instantly using reactive GetX." },
      { icon: "🏆", title: "100% Completion Trigger", desc: "Automatically triggers certificate claiming once all lessons are checked." }
    ],
    phoneTheme: "light",
    phoneContentHtml: `
      <div style="padding: 16px; background: #FFF; border-bottom: 1px solid #E2E8F0;">
        <div style="font-size: 11px; color: #64748B; text-transform: uppercase; font-weight: 700;">Ongoing Course</div>
        <div style="font-size: 16px; font-weight: 900; color: #0F172A; margin: 2px 0 10px 0;">Mobile App Architecture</div>
        <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 6px;">
          <span style="font-size: 12px; font-weight: 800; color: #EA580C;">80% Completed</span>
          <span style="font-size: 11px; color: #64748B;">8 of 10 Lessons</span>
        </div>
        <div style="height: 6px; background: #E2E8F0; border-radius: 3px; overflow: hidden;">
          <div style="width: 80%; height: 100%; background: #EA580C;"></div>
        </div>
      </div>
      <div style="padding: 12px 16px; display: flex; flex-direction: column; gap: 8px;">
        <div style="background: #FFF; border: 1px solid #E2E8F0; border-radius: 10px; padding: 10px; display: flex; align-items: center; gap: 10px;">
          <span style="color: #10B981; font-weight: 900; font-size: 16px;">✓</span>
          <span style="font-size: 12px; text-decoration: line-through; color: #94A3B8;">01. Introduction to MVVM</span>
        </div>
        <div style="background: #FFF; border: 1px solid #E2E8F0; border-radius: 10px; padding: 10px; display: flex; align-items: center; gap: 10px;">
          <span style="color: #10B981; font-weight: 900; font-size: 16px;">✓</span>
          <span style="font-size: 12px; text-decoration: line-through; color: #94A3B8;">02. Dependency Injection</span>
        </div>
        <div style="background: #FFF7ED; border: 1px solid #FED7AA; border-radius: 10px; padding: 10px; display: flex; align-items: center; gap: 10px;">
          <span style="color: #EA580C; font-weight: 900; font-size: 16px;">▶</span>
          <span style="font-size: 12px; font-weight: 700; color: #9A3412;">03. Local Database Caching</span>
        </div>
        <div style="background: #FFF; border: 1px solid #E2E8F0; border-radius: 10px; padding: 10px; display: flex; align-items: center; gap: 10px;">
          <span style="color: #CBD5E1; font-size: 16px;">○</span>
          <span style="font-size: 12px; color: #475569;">04. Unit Testing Controllers</span>
        </div>
      </div>
    `
  },

  // SLIDE 7: In-Course Q&A Community
  {
    fileName: "07_in_course_qna_forum.png",
    category: "STUDENT APP",
    isInstructor: false,
    headline: "In-Course Q&A Community Forum",
    subheadline: "Students ask questions directly inside lectures. Official instructor responses are highlighted with verified badges.",
    chips: [
      { icon: "💬", title: "Direct In-Lecture Queries", desc: "No need to leave the player to get clarification on code snippets." },
      { icon: "🛡️", title: "Verified Instructor Badge", desc: "Instructor replies are stamped with golden verification badges." },
      { icon: "🤝", title: "Community Peer Learning", desc: "Students can discuss, upvote, and collaborate on solutions." }
    ],
    phoneTheme: "light",
    phoneContentHtml: `
      <div style="padding: 14px 16px; background: #FFF; border-bottom: 1px solid #E2E8F0; display: flex; justify-content: space-between; align-items: center;">
        <div style="font-size: 15px; font-weight: 800; color: #0F172A;">Lecture Q&A (24)</div>
        <button style="background: #EA580C; color: #FFF; border: none; padding: 4px 10px; border-radius: 6px; font-size: 11px; font-weight: 700;">Ask Question</button>
      </div>
      <div style="padding: 12px 16px; display: flex; flex-direction: column; gap: 12px;">
        <!-- Question Item -->
        <div style="background: #FFF; border: 1px solid #E2E8F0; border-radius: 12px; padding: 12px;">
          <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 6px;">
            <div style="width: 24px; height: 24px; border-radius: 50%; background: #64748B; color: #FFF; display: flex; align-items: center; justify-content: center; font-size: 10px;">JD</div>
            <div style="font-size: 11px; font-weight: 700;">John Doe</div>
            <span style="font-size: 9.5px; color: #94A3B8;">&bull; 2h ago</span>
          </div>
          <div style="font-size: 12px; font-weight: 700; color: #0F172A; margin-bottom: 4px;">How to handle token expiration in GetX?</div>
          <!-- Instructor Reply -->
          <div style="margin-top: 8px; background: #FFFDF5; border: 1px solid #FED7AA; border-radius: 8px; padding: 8px 10px;">
            <div style="display: flex; align-items: center; gap: 6px; margin-bottom: 4px;">
              <span style="background: #D4AF37; color: #000; font-size: 8.5px; font-weight: 900; padding: 2px 5px; border-radius: 4px;">VERIFIED INSTRUCTOR</span>
              <span style="font-size: 10.5px; font-weight: 800;">Michael Chen</span>
            </div>
            <div style="font-size: 11px; color: #475569; line-height: 1.4;">
              Use an ApiClient interceptor that catches 401 status codes and navigates to Get.offAllNamed(AppRoutes.login).
            </div>
          </div>
        </div>
      </div>
    `
  },

  // SLIDE 8: Instructor Profile & Follow Counter
  {
    fileName: "08_instructor_profile_follow.png",
    category: "STUDENT APP",
    isInstructor: false,
    headline: "Instructor Profiles & Reactive Follow Counter",
    subheadline: "Learners explore instructor bios, credentials, and courses, with a live reactive follow counter updating across screens.",
    chips: [
      { icon: "👥", title: "Reactive Follow Counter", desc: "Tap 'Follow' to increment the instructor's total audience count in real time." },
      { icon: "⭐", title: "Instructor Credentials", desc: "Showcases total students, courses authored, and average rating." },
      { icon: "🌐", title: "Social Profiles & Bio", desc: "Direct links to instructor website, LinkedIn, and social media." }
    ],
    phoneTheme: "light",
    phoneContentHtml: `
      <div style="background: linear-gradient(135deg, #1C1917, #2A2521); padding: 24px 16px; color: #FFF; text-align: center;">
        <div style="width: 72px; height: 72px; border-radius: 50%; background: #D4AF37; margin: 0 auto 10px auto; display: flex; align-items: center; justify-content: center; font-size: 28px; font-weight: 900; color: #000; border: 3px solid #FFF;">
          MC
        </div>
        <div style="font-size: 17px; font-weight: 800;">Michael Chen</div>
        <div style="font-size: 11px; color: #D4AF37; font-weight: 600;">Flutter Google Developer Expert (GDE)</div>
        <div style="display: flex; justify-content: center; gap: 20px; margin-top: 14px; padding-top: 12px; border-top: 1px solid rgba(255,255,255,0.1);">
          <div><div style="font-size: 14px; font-weight: 800;">22,100</div><div style="font-size: 10px; color: #94A3B8;">Students</div></div>
          <div><div style="font-size: 14px; font-weight: 800;">12</div><div style="font-size: 10px; color: #94A3B8;">Courses</div></div>
          <div><div style="font-size: 14px; font-weight: 800;">4.9 ★</div><div style="font-size: 10px; color: #94A3B8;">Rating</div></div>
        </div>
      </div>
      <div style="padding: 16px;">
        <button style="width: 100%; height: 42px; background: #EA580C; border: none; border-radius: 10px; color: #FFF; font-weight: 800; font-size: 13px; display: flex; align-items: center; justify-content: center; gap: 6px; box-shadow: 0 4px 12px rgba(234,88,12,0.3);">
          <span>✓</span> Following (4,892)
        </button>
        <div style="margin-top: 16px; font-size: 13px; font-weight: 800; color: #0F172A;">Popular Courses by Michael</div>
      </div>
    `
  },

  // SLIDE 9: Verifiable Digital Certificate
  {
    fileName: "09_digital_certificate_stamping.png",
    category: "STANDOUT COMMERCIAL FEATURE",
    isInstructor: false,
    headline: "Verifiable Digital Certificate Generation",
    subheadline: "On completing 100% of the curriculum, students unlock an authentic certificate carrying the instructor's digital signature.",
    chips: [
      { icon: "📜", title: "High-Resolution Certificate", desc: "Rendered dynamically with student name, course title, and date." },
      { icon: "✍️", title: "Instructor Digital Signature", desc: "Directly linked to the Instructor Studio's registered signature." },
      { icon: "🔢", title: "Unique Verification Code", desc: "Includes tamper-proof serial string (e.g. SKL-2024-8849)." }
    ],
    phoneTheme: "light",
    phoneContentHtml: `
      <div style="padding: 16px; background: #FFF; flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center;">
        <div style="font-size: 12px; font-weight: 800; color: #10B981; margin-bottom: 8px;">🎉 COURSE COMPLETED!</div>
        <!-- Certificate Card -->
        <div style="width: 100%; border: 3px solid #D4AF37; border-radius: 12px; padding: 16px; background: #FFFDF5; text-align: center; box-shadow: 0 10px 20px rgba(212,175,55,0.15); position: relative;">
          <div style="font-size: 10px; letter-spacing: 2px; text-transform: uppercase; color: #D4AF37; font-weight: 800;">Certificate of Completion</div>
          <div style="font-size: 9px; color: #64748B; margin-top: 2px;">This is proudly presented to</div>
          <div style="font-size: 16px; font-weight: 900; color: #0F172A; margin: 6px 0;">Alex Morgan</div>
          <div style="font-size: 9.5px; color: #64748B;">for successfully mastering</div>
          <div style="font-size: 12px; font-weight: 800; color: #EA580C; margin: 4px 0;">Flutter & GetX Architecture</div>
          
          <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-top: 14px; padding-top: 8px; border-top: 1px dashed #CBD5E1;">
            <div style="text-align: left;">
              <div style="font-size: 8px; color: #94A3B8;">SERIAL NO.</div>
              <div style="font-size: 9px; font-weight: 700; color: #0F172A;">SKL-2024-9102</div>
            </div>
            <div style="text-align: right;">
              <div style="font-family: cursive; font-size: 14px; color: #0F172A;">Michael Chen</div>
              <div style="font-size: 8px; color: #D4AF37; font-weight: 700;">Verified Instructor</div>
            </div>
          </div>
        </div>
        <button style="margin-top: 16px; width: 100%; height: 40px; background: #EA580C; border: none; border-radius: 10px; color: #FFF; font-weight: 800; font-size: 12px;">
          Download / Share Certificate
        </button>
      </div>
    `
  },

  // SLIDE 10: Ratings & Reviews System
  {
    fileName: "10_ratings_reviews_system.png",
    category: "STUDENT APP",
    isInstructor: false,
    headline: "5-Star Rating & Review Feedback",
    subheadline: "Students rate courses, write in-depth reviews, view rating bar distributions, and help other learners discover quality courses.",
    chips: [
      { icon: "⭐", title: "5-Star Interactive Rating", desc: "Intuitive touch star selection with half-star accuracy." },
      { icon: "📊", title: "Visual Rating Breakdown", desc: "Progress bars displaying percentage distribution of 1 to 5 stars." },
      { icon: "💬", title: "Verified Student Feedback", desc: "Detailed testimonials with reviewer profile pictures and timestamps." }
    ],
    phoneTheme: "light",
    phoneContentHtml: `
      <div style="padding: 16px; background: #FFF; border-bottom: 1px solid #E2E8F0;">
        <div style="font-size: 16px; font-weight: 800; color: #0F172A; margin-bottom: 8px;">Student Reviews</div>
        <div style="display: flex; align-items: center; gap: 14px;">
          <div style="text-align: center;">
            <div style="font-size: 32px; font-weight: 900; color: #0F172A; line-height: 1;">4.9</div>
            <div style="color: #F59E0B; font-size: 12px; margin-top: 2px;">★★★★★</div>
            <div style="font-size: 10px; color: #94A3B8;">2,410 reviews</div>
          </div>
          <div style="flex: 1; display: flex; flex-direction: column; gap: 3px;">
            <div style="display: flex; align-items: center; gap: 6px; font-size: 10px;"><span style="width: 12px;">5★</span><div style="flex:1; height:4px; background:#E2E8F0; border-radius:2px;"><div style="width:90%; height:100%; background:#F59E0B;"></div></div></div>
            <div style="display: flex; align-items: center; gap: 6px; font-size: 10px;"><span style="width: 12px;">4★</span><div style="flex:1; height:4px; background:#E2E8F0; border-radius:2px;"><div style="width:8%; height:100%; background:#F59E0B;"></div></div></div>
            <div style="display: flex; align-items: center; gap: 6px; font-size: 10px;"><span style="width: 12px;">3★</span><div style="flex:1; height:4px; background:#E2E8F0; border-radius:2px;"><div style="width:2%; height:100%; background:#F59E0B;"></div></div></div>
          </div>
        </div>
      </div>
      <div style="padding: 12px 16px;">
        <div style="background: #F8FAFC; border: 1px solid #E2E8F0; border-radius: 10px; padding: 10px;">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 4px;">
            <span style="font-size: 11px; font-weight: 800;">Elena Rostova</span>
            <span style="color: #F59E0B; font-size: 11px;">★★★★★</span>
          </div>
          <div style="font-size: 11px; color: #64748B; line-height: 1.4;">
            "The GetX architecture and reactive controllers made complex state management crystal clear. Highly recommend!"
          </div>
        </div>
      </div>
    `
  },

  // SLIDE 11: Instructor Revenue & Analytics Dashboard
  {
    fileName: "11_instructor_revenue_dashboard.png",
    category: "INSTRUCTOR STUDIO",
    isInstructor: true,
    headline: "Instructor Revenue & Executive Analytics",
    subheadline: "Real-time earnings tracking, active enrolled student count, follower growth statistics, and recent purchase activity.",
    chips: [
      { icon: "💰", title: "Live Revenue Overview", desc: "Lifetime earnings, monthly revenue, and average student order value." },
      { icon: "📈", title: "Active Student Counter", desc: "Monitor active enrollments across all published courses." },
      { icon: "🔔", title: "Recent Enrollments Feed", desc: "Instant notifications whenever a learner enrolls in a lecture." }
    ],
    phoneTheme: "dark",
    phoneContentHtml: `
      <div style="padding: 14px 16px; background: #1C1917; border-bottom: 1px solid #2B2A2E; display: flex; justify-content: space-between; align-items: center;">
        <div>
          <div style="font-size: 10px; color: #D4AF37; font-weight: 700; text-transform: uppercase;">Analytics Overview</div>
          <div style="font-size: 15px; font-weight: 800; color: #FFF;">Dashboard Metrics</div>
        </div>
        <span style="background: rgba(16,185,129,0.15); color: #10B981; font-size: 10px; font-weight: 800; padding: 3px 8px; border-radius: 6px;">LIVE SYNC</span>
      </div>
      <div style="padding: 12px 16px; display: flex; flex-direction: column; gap: 10px;">
        <!-- Revenue Card -->
        <div style="background: linear-gradient(135deg, #2A2521, #1C1917); border: 1px solid rgba(212,175,55,0.35); border-radius: 14px; padding: 14px;">
          <div style="font-size: 10.5px; color: #A8A29E;">Total Revenue (This Month)</div>
          <div style="font-size: 26px; font-weight: 900; color: #FBBF24; margin: 2px 0;">$14,850.00</div>
          <div style="font-size: 10.5px; color: #10B981;">▲ +24.8% vs last month</div>
        </div>
        <!-- 2 Metric Cards -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 8px;">
          <div style="background: #23201D; border-radius: 10px; padding: 10px; border: 1px solid rgba(255,255,255,0.06);">
            <div style="font-size: 10px; color: #A8A29E;">Total Students</div>
            <div style="font-size: 18px; font-weight: 800; color: #FFF; margin-top: 2px;">22,100</div>
          </div>
          <div style="background: #23201D; border-radius: 10px; padding: 10px; border: 1px solid rgba(255,255,255,0.06);">
            <div style="font-size: 10px; color: #A8A29E;">Avg Rating</div>
            <div style="font-size: 18px; font-weight: 800; color: #F59E0B; margin-top: 2px;">4.9 ★</div>
          </div>
        </div>
      </div>
    `
  },

  // SLIDE 12: Course Studio & Curriculum Builder
  {
    fileName: "12_course_studio_builder.png",
    category: "INSTRUCTOR STUDIO",
    isInstructor: true,
    headline: "Course Studio & Curriculum Builder",
    subheadline: "Educators can author new courses, organize chapters, add video lectures, and set free preview toggles seamlessly.",
    chips: [
      { icon: "🛠️", title: "Multi-Step Wizard", desc: "Basic details, pricing, media thumbnail, and curriculum chapters." },
      { icon: "📁", title: "Module & Lecture Tree", desc: "Add unlimited modules and reorder lectures with drag & drop." },
      { icon: "🔓", title: "Free Preview Toggle", desc: "Designate specific introductory videos as free samples." }
    ],
    phoneTheme: "dark",
    phoneContentHtml: `
      <div style="padding: 14px 16px; background: #1C1917; border-bottom: 1px solid #2B2A2E;">
        <div style="font-size: 10px; color: #D4AF37; font-weight: 700; text-transform: uppercase;">Course Studio</div>
        <div style="font-size: 15px; font-weight: 800; color: #FFF;">Create New Course</div>
      </div>
      <div style="padding: 12px 16px; display: flex; flex-direction: column; gap: 10px;">
        <div style="background: #23201D; border: 1px solid rgba(255,255,255,0.08); border-radius: 10px; padding: 12px;">
          <div style="font-size: 10.5px; color: #A8A29E; margin-bottom: 4px;">Course Title</div>
          <div style="font-size: 12px; font-weight: 700; color: #FFF;">Flutter Enterprise Architecture</div>
        </div>
        <div style="background: #23201D; border: 1px solid rgba(255,255,255,0.08); border-radius: 10px; padding: 12px;">
          <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px;">
            <div style="font-size: 11px; font-weight: 800; color: #D4AF37;">Chapter 1: State Management</div>
            <span style="font-size: 10px; color: #10B981;">+ Add Lecture</span>
          </div>
          <div style="background: #1C1917; padding: 6px 8px; border-radius: 6px; font-size: 11px; margin-bottom: 4px;">
            1.1 Overview of GetX Controller
          </div>
          <div style="background: #1C1917; padding: 6px 8px; border-radius: 6px; font-size: 11px;">
            1.2 Obx vs GetBuilder (Free Preview)
          </div>
        </div>
        <button style="width: 100%; height: 38px; background: linear-gradient(135deg, #EA580C, #F97316); border: none; border-radius: 8px; color: #FFF; font-weight: 800; font-size: 12px;">
          Publish Course
        </button>
      </div>
    `
  },

  // SLIDE 13: Instructor Q&A Resolution Hub
  {
    fileName: "13_instructor_qa_resolution_hub.png",
    category: "INSTRUCTOR STUDIO",
    isInstructor: true,
    headline: "Instructor Q&A Resolution Hub",
    subheadline: "Educators manage incoming student doubts, filter by unanswered status, and dispatch verified answers instantly.",
    chips: [
      { icon: "📬", title: "Unanswered Filter", desc: "Quickly focus on pending questions to keep response times high." },
      { icon: "⚡", title: "One-Tap Reply Modal", desc: "Compose formatted code snippets or quick troubleshooting advice." },
      { icon: "🏅", title: "Automated Badge Marking", desc: "Replies are automatically flagged as official instructor solutions." }
    ],
    phoneTheme: "dark",
    phoneContentHtml: `
      <div style="padding: 14px 16px; background: #1C1917; border-bottom: 1px solid #2B2A2E; display: flex; justify-content: space-between; align-items: center;">
        <div style="font-size: 15px; font-weight: 800; color: #FFF;">Q&A Resolution Hub</div>
        <span style="background: #EA580C; color: #FFF; font-size: 10px; font-weight: 800; padding: 2px 7px; border-radius: 10px;">12 Pending</span>
      </div>
      <div style="padding: 12px 16px; display: flex; flex-direction: column; gap: 10px;">
        <div style="display: flex; gap: 8px;">
          <span style="background: #D4AF37; color: #000; padding: 4px 10px; border-radius: 14px; font-size: 10.5px; font-weight: 800;">Unanswered (12)</span>
          <span style="background: #23201D; color: #A8A29E; padding: 4px 10px; border-radius: 14px; font-size: 10.5px; font-weight: 600;">All (184)</span>
        </div>
        <div style="background: #23201D; border: 1px solid rgba(255,255,255,0.08); border-radius: 10px; padding: 12px;">
          <div style="font-size: 10px; color: #A8A29E; margin-bottom: 2px;">In: Flutter & GetX Masterclass</div>
          <div style="font-size: 12px; font-weight: 800; color: #FFF; margin-bottom: 6px;">How to test reactive Obx widgets?</div>
          <div style="font-size: 11px; color: #CBD5E1; margin-bottom: 8px;">"I am trying to write flutter_test unit tests..."</div>
          <button style="width: 100%; height: 32px; background: #D4AF37; border: none; border-radius: 6px; color: #000; font-weight: 800; font-size: 11px;">
            Reply as Verified Instructor
          </button>
        </div>
      </div>
    `
  },

  // SLIDE 14: Instructor Wallet & Payout Requests
  {
    fileName: "14_wallet_payout_requests.png",
    category: "INSTRUCTOR STUDIO",
    isInstructor: true,
    headline: "Instructor Wallet & Payout System",
    subheadline: "Educators manage available balances, review lifetime earnings, and submit payout requests to Bank Transfer or PayPal.",
    chips: [
      { icon: "💳", title: "Multiple Payout Channels", desc: "Support for direct Bank Wire Transfer, Stripe, and PayPal payouts." },
      { icon: "📝", title: "Complete Withdrawal Logs", desc: "Track transaction IDs, payout dates, and processing status." },
      { icon: "🔒", title: "Secure Payout Validation", desc: "Built-in minimum withdrawal limits and account verification." }
    ],
    phoneTheme: "dark",
    phoneContentHtml: `
      <div style="padding: 14px 16px; background: #1C1917; border-bottom: 1px solid #2B2A2E;">
        <div style="font-size: 10px; color: #D4AF37; font-weight: 700; text-transform: uppercase;">Finance & Wallet</div>
        <div style="font-size: 15px; font-weight: 800; color: #FFF;">Earnings & Payouts</div>
      </div>
      <div style="padding: 12px 16px; display: flex; flex-direction: column; gap: 10px;">
        <div style="background: #23201D; border-radius: 14px; padding: 14px; border: 1px solid rgba(255,255,255,0.08);">
          <div style="font-size: 10.5px; color: #A8A29E;">Available for Withdrawal</div>
          <div style="font-size: 24px; font-weight: 900; color: #10B981; margin: 2px 0;">$4,250.00</div>
          <div style="font-size: 10px; color: #94A3B8;">Lifetime Total: $38,400.00</div>
        </div>
        <div style="background: #23201D; border-radius: 10px; padding: 12px; border: 1px solid rgba(255,255,255,0.08);">
          <div style="font-size: 11px; font-weight: 800; color: #FFF; margin-bottom: 8px;">Request Payout</div>
          <div style="background: #1C1917; padding: 8px; border-radius: 6px; font-size: 11px; color: #A8A29E; margin-bottom: 8px;">
            Method: Bank Wire (**** 4892)
          </div>
          <button style="width: 100%; height: 36px; background: #10B981; border: none; border-radius: 8px; color: #FFF; font-weight: 800; font-size: 11.5px;">
            Withdraw $4,250.00
          </button>
        </div>
      </div>
    `
  },

  // SLIDE 15: Digital Signature Studio
  {
    fileName: "15_digital_signature_studio.png",
    category: "INSTRUCTOR STUDIO",
    isInstructor: true,
    headline: "Digital Signature Studio for Certificates",
    subheadline: "Instructors register official cursive script signatures or upload PNG signature assets to stamp on student certificates.",
    chips: [
      { icon: "✍️", title: "Stylized Script Studio", desc: "Select from curated elegant cursive calligraphic typography." },
      { icon: "🖼️", title: "Custom PNG Upload", desc: "Upload transparent handwritten signatures from camera or gallery." },
      { icon: "📜", title: "Live Certificate Preview", desc: "Preview how the signature looks stamped on student credentials." }
    ],
    phoneTheme: "dark",
    phoneContentHtml: `
      <div style="padding: 14px 16px; background: #1C1917; border-bottom: 1px solid #2B2A2E;">
        <div style="font-size: 10px; color: #D4AF37; font-weight: 700; text-transform: uppercase;">Credential Settings</div>
        <div style="font-size: 15px; font-weight: 800; color: #FFF;">Digital Signature Studio</div>
      </div>
      <div style="padding: 12px 16px; display: flex; flex-direction: column; gap: 10px;">
        <div style="background: #23201D; border-radius: 12px; padding: 14px; text-align: center; border: 1px dashed #D4AF37;">
          <div style="font-size: 10.5px; color: #A8A29E; margin-bottom: 6px;">Active Official Signature</div>
          <div style="font-family: cursive; font-size: 26px; color: #FBBF24; padding: 10px 0;">
            Michael Chen
          </div>
          <div style="font-size: 9.5px; color: #10B981; font-weight: 700;">✓ Stamped on 1,420 Issued Certificates</div>
        </div>
        <div style="display: flex; gap: 8px;">
          <button style="flex: 1; height: 36px; background: #2B2A2E; border: 1px solid rgba(255,255,255,0.1); border-radius: 8px; color: #FFF; font-size: 11px; font-weight: 700;">
            Change Font
          </button>
          <button style="flex: 1; height: 36px; background: #D4AF37; border: none; border-radius: 8px; color: #000; font-size: 11px; font-weight: 800;">
            Upload PNG
          </button>
        </div>
      </div>
    `
  },

  // SLIDE 16: Multi-Language & Clean GetX Architecture
  {
    fileName: "16_multilingual_clean_architecture.png",
    category: "DEVELOPER READY",
    isInstructor: false,
    headline: "Multi-Language & Clean GetX Architecture",
    subheadline: "Ready for global audiences with 5 integrated languages (English, Hindi, Gujarati, Italian, Chinese) and modular clean code.",
    chips: [
      { icon: "🌐", title: "5 International Languages", desc: "EN, HI, GU, IT, and ZH bundled via JSON localization files." },
      { icon: "🧩", title: "Modular Architecture", desc: "Independent View, Controller, and Service separation." },
      { icon: "🚀", title: "Production Grade", desc: "Tested on Flutter 3.24+ with 0 lint warnings and 0 compilation errors." }
    ],
    phoneTheme: "light",
    phoneContentHtml: `
      <div style="padding: 14px 16px; background: #FFF; border-bottom: 1px solid #E2E8F0;">
        <div style="font-size: 15px; font-weight: 800; color: #0F172A;">Language Settings</div>
        <div style="font-size: 11px; color: #64748B;">Select your preferred language</div>
      </div>
      <div style="padding: 12px 16px; display: flex; flex-direction: column; gap: 8px;">
        <div style="background: #FFF7ED; border: 1px solid #FED7AA; border-radius: 10px; padding: 10px 12px; display: flex; justify-content: space-between; align-items: center;">
          <div style="font-size: 12px; font-weight: 800; color: #9A3412;">English (US)</div>
          <span style="color: #EA580C; font-weight: 900;">✓</span>
        </div>
        <div style="background: #FFF; border: 1px solid #E2E8F0; border-radius: 10px; padding: 10px 12px; display: flex; justify-content: space-between; align-items: center;">
          <div style="font-size: 12px; font-weight: 600; color: #0F172A;">Hindi (हिंदी)</div>
        </div>
        <div style="background: #FFF; border: 1px solid #E2E8F0; border-radius: 10px; padding: 10px 12px; display: flex; justify-content: space-between; align-items: center;">
          <div style="font-size: 12px; font-weight: 600; color: #0F172A;">Gujarati (ગુજરાતી)</div>
        </div>
        <div style="background: #FFF; border: 1px solid #E2E8F0; border-radius: 10px; padding: 10px 12px; display: flex; justify-content: space-between; align-items: center;">
          <div style="font-size: 12px; font-weight: 600; color: #0F172A;">Italian (Italiano)</div>
        </div>
        <div style="background: #FFF; border: 1px solid #E2E8F0; border-radius: 10px; padding: 10px 12px; display: flex; justify-content: space-between; align-items: center;">
          <div style="font-size: 12px; font-weight: 600; color: #0F172A;">Chinese (中文)</div>
        </div>
      </div>
    `
  }
];

// EXECUTE RENDERING FOR ALL 16 SLIDES
console.log(`Starting gallery generation for ${slides.length} slides...`);

slides.forEach((slide, index) => {
  const html = createSlideHtml(slide);
  const outPath = path.join(dirGallery, slide.fileName);
  console.log(`[${index + 1}/${slides.length}] Generating ${slide.fileName}...`);
  renderScreenshot(html, 1200, 800, outPath);
});

console.log("All 16 gallery mockup slides generated successfully!");
