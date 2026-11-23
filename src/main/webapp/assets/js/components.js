// Mijusan Interactive Components

// 1. User Menu Dropdown
function initUserMenus() {
    document.querySelectorAll('[data-user-menu]').forEach((root) => {
        if (root.dataset.initialized) return;
        root.dataset.initialized = 'true';
        const trigger = root.querySelector('[data-trigger]');
        const menu = root.querySelector('[data-menu]');
        if (!trigger || !menu) return;

        const close = () => {
            menu.hidden = true;
            trigger.setAttribute('aria-expanded', 'false');
        };

        const open = () => {
            menu.hidden = false;
            trigger.setAttribute('aria-expanded', 'true');
        };

        trigger.addEventListener('click', (e) => {
            e.stopPropagation();
            menu.hidden ? open() : close();
        });

        document.addEventListener('click', (event) => {
            if (!root.contains(event.target)) close();
        });

        root.addEventListener('keydown', (event) => {
            if (event.key === 'Escape') {
                close();
                trigger.focus();
            }
        });
    });
}

// 2. Admin Range Select Dropdown
function initRangeSelects() {
    document.querySelectorAll('[data-range-select]').forEach((root) => {
        if (root.dataset.initialized) return;
        root.dataset.initialized = 'true';
        const trigger = root.querySelector('[data-trigger]');
        const menu = root.querySelector('[data-menu]');
        const label = root.querySelector('[data-label]');
        const options = root.querySelectorAll('[data-value]');
        const navigate = root.dataset.navigate === 'true';
        const param = root.dataset.param || 'range';
        if (!trigger || !menu) return;

        const close = () => {
            menu.hidden = true;
            trigger.setAttribute('aria-expanded', 'false');
        };

        const open = () => {
            menu.hidden = false;
            trigger.setAttribute('aria-expanded', 'true');
        };

        trigger.addEventListener('click', (e) => {
            e.stopPropagation();
            menu.hidden ? open() : close();
        });

        options.forEach((option) => {
            option.addEventListener('click', () => {
                options.forEach((o) => {
                    const active = o === option;
                    o.setAttribute('aria-selected', active ? 'true' : 'false');
                    o.classList.toggle('bg-cream-dark', active);
                    o.classList.toggle('font-medium', active);
                    o.classList.toggle('font-normal', !active);
                });

                const text = option.textContent.trim();
                if (label) label.textContent = text;
                close();

                root.dispatchEvent(new CustomEvent('range-change', {
                    bubbles: true,
                    detail: { value: option.dataset.value, label: text },
                }));

                if (navigate) {
                    const url = new URL(window.location.href);
                    url.searchParams.set(param, option.dataset.value);
                    window.location.href = url.toString();
                }
            });
        });

        document.addEventListener('click', (event) => {
            if (!root.contains(event.target)) close();
        });

        root.addEventListener('keydown', (event) => {
            if (event.key === 'Escape') {
                close();
                trigger.focus();
            }
        });
    });
}

// 3. Order Chart Hover Tooltip
function initChartTooltips() {
    document.querySelectorAll('[data-chart-root]').forEach((root) => {
        if (root.dataset.initialized) return;
        root.dataset.initialized = 'true';
        const tooltip = root.querySelector('[data-tooltip]');
        const valEl = root.querySelector('[data-tooltip-val]');
        const labelEl = root.querySelector('[data-tooltip-label]');
        const groups = root.querySelectorAll('.chart-point-group');
        if (!tooltip) return;

        groups.forEach((group, index) => {
            group.addEventListener('mouseenter', () => {
                const val = group.dataset.val;
                const label = group.dataset.label;
                const x = parseFloat(group.dataset.x);
                const y = parseFloat(group.dataset.y);

                if (valEl) valEl.textContent = `${val} order${val === '1' ? '' : 's'}`;
                if (labelEl) labelEl.textContent = label;

                let transformX = '-50%';
                if (index === 0) transformX = '-10%';
                if (index === groups.length - 1) transformX = '-90%';

                tooltip.style.left = `${x}%`;
                tooltip.style.top = `calc(${y}% - 14px)`;
                tooltip.style.transform = `translate(${transformX}, -100%)`;
                tooltip.hidden = false;
            });

            group.addEventListener('mouseleave', () => {
                tooltip.hidden = true;
            });
        });
    });
}

// 4. Carousels
function initCarousels() {
    document.querySelectorAll('[data-carousel]').forEach((carousel) => {
        if (carousel.dataset.initialized) return;
        carousel.dataset.initialized = 'true';
        const track = carousel.querySelector('[data-carousel-track]');
        const prev = carousel.querySelector('[data-carousel-prev]');
        const next = carousel.querySelector('[data-carousel-next]');
        if (!track) return;

        const update = () => {
            if (!prev || !next) return;
            const max = track.scrollWidth - track.clientWidth - 1;
            prev.hidden = track.scrollLeft <= 0;
            next.hidden = track.scrollLeft >= max;
        };

        const scrollByPage = (dir) =>
            track.scrollBy({ left: dir * track.clientWidth * 0.8, behavior: 'smooth' });

        if (prev) prev.addEventListener('click', () => scrollByPage(-1));
        if (next) next.addEventListener('click', () => scrollByPage(1));
        track.addEventListener('scroll', update, { passive: true });
        window.addEventListener('resize', update);
        update();
    });
}

document.addEventListener('DOMContentLoaded', () => {
    initUserMenus();
    initRangeSelects();
    initChartTooltips();
    initCarousels();
});
