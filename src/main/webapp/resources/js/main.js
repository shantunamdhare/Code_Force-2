/* ============================================
   CodeForce Pro - Main JavaScript Update
   ============================================ */

document.addEventListener('DOMContentLoaded', function() {
    initSidebar();
    initCountdowns();
    initAnimations();
    initTooltips();
});

/* ============ SIDEBAR TOGGLE ============ */
function initSidebar() {
    const sidebar = document.getElementById('sidebar');
    if (!sidebar) return; // Exit if in classic mode/no sidebar

    const toggle = document.createElement('button');
    toggle.className = 'sidebar-toggle-btn';
    toggle.innerHTML = '<i class="ph ph-list"></i>';
    toggle.style.cssText = 'position:fixed; top:20px; left:20px; z-index:2000; background:white; border:1px solid var(--gray-200); padding:8px; border-radius:8px; display:none;';
    
    document.body.appendChild(toggle);

    // Responsive helper
    function checkRes() {
        if (window.innerWidth <= 1024) {
            toggle.style.display = 'block';
        } else {
            toggle.style.display = 'none';
            sidebar.classList.remove('open');
        }
    }

    toggle.addEventListener('click', function() {
        sidebar.classList.toggle('open');
        toggle.querySelector('i').className = sidebar.classList.contains('open') ? 'ph ph-x' : 'ph ph-list';
    });

    window.addEventListener('resize', checkRes);
    checkRes();
}

/* ============ COUNTDOWN TIMERS ============ */
function initCountdowns() {
    // 1. Details Page Countdowns (Days/Hours/Min/Sec)
    const timers = document.querySelectorAll('.countdown-timer');
    timers.forEach(timer => {
        const endTimeStr = timer.getAttribute('data-countdown');
        if (!endTimeStr) return;

        const endTime = new Date(endTimeStr).getTime();
        const units = timer.querySelectorAll('.number');

        if (units.length === 4) {
            const update = () => {
                const now = new Date().getTime();
                const distance = endTime - now;

                if (distance < 0) {
                    timer.innerHTML = "<div style='color:var(--primary-teal); font-weight:700;'>Contest has started!</div>";
                    return;
                }

                const d = Math.floor(distance / (1000 * 60 * 60 * 24));
                const h = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const m = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const s = Math.floor((distance % (1000 * 60)) / 1000);

                units[0].innerText = String(d).padStart(2, '0');
                units[1].innerText = String(h).padStart(2, '0');
                units[2].innerText = String(m).padStart(2, '0');
                units[3].innerText = String(s).padStart(2, '0');
            };
            
            update();
            setInterval(update, 1000);
        }
    });

    // 2. Simple Sticky Timer (h:m:s)
    const stickyTimer = document.getElementById('sticky-timer');
    if (stickyTimer) {
        setInterval(() => {
            let timeParts = stickyTimer.innerText.split(':');
            if (timeParts.length < 3) return;
            let totalSec = parseInt(timeParts[0]) * 3600 + parseInt(timeParts[1]) * 60 + parseInt(timeParts[2]);
            if (totalSec > 0) {
                totalSec--;
                let h = Math.floor(totalSec / 3600);
                let m = Math.floor((totalSec % 3600) / 60);
                let s = totalSec % 60;
                stickyTimer.innerText = `${String(h).padStart(2, '0')}:${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`;
            }
        }, 1000);
    }
}

/* ============ ANIMATIONS ============ */
function initAnimations() {
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-up');
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.glass-card, .stat-card').forEach(el => {
        observer.observe(el);
    });
}

/* ============ TOOLTIPS ============ */
function initTooltips() {
    // Basic interaction for locked cards
    document.querySelectorAll('.locked').forEach(el => {
        el.addEventListener('click', (e) => {
            e.preventDefault();
            alert("This content is locked. Increase your rating to unlock this topic!");
        });
    });
}
