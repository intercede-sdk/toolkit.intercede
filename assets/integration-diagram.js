(() => {
    const link = document.querySelector('[data-integration-diagram]');
    if (!link || typeof HTMLDialogElement === 'undefined') {
        return;
    }

    const dialog = document.createElement('dialog');
    dialog.className = 'integration-diagram';
    dialog.setAttribute('aria-labelledby', 'integration-diagram-title');
    dialog.innerHTML = `
        <div class="integration-diagram-heading">
            <h2 id="integration-diagram-title">MyID client integration</h2>
            <button type="button" class="integration-diagram-close" aria-label="Close integration diagram" title="Close integration diagram" autofocus>
                <i class="fas fa-times" aria-hidden="true"></i>
            </button>
        </div>
        <img alt="MyID flexible client integration diagram">
    `;
    dialog.querySelector('img').src = link.href;
    document.body.append(dialog);

    link.addEventListener('click', (event) => {
        event.preventDefault();
        dialog.showModal();
        document.body.classList.add('integration-diagram-open');
    });

    dialog.querySelector('button').addEventListener('click', () => dialog.close());
    dialog.addEventListener('keydown', (event) => {
        if (event.key === 'Escape') {
            event.preventDefault();
            dialog.close();
        }
    });
    dialog.addEventListener('click', (event) => {
        if (event.target === dialog) {
            const bounds = dialog.getBoundingClientRect();
            if (event.clientX < bounds.left || event.clientX > bounds.right ||
                event.clientY < bounds.top || event.clientY > bounds.bottom) {
                dialog.close();
            }
        }
    });
    dialog.addEventListener('close', () => {
        document.body.classList.remove('integration-diagram-open');
    });
})();