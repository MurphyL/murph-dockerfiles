// https://json-editor.github.io/json-editor/

/**
document.addEventListener('DOMContentLoaded', () => {
    const params = new URLSearchParams(location.search);
    fetch(params.get('file')).then(res => res.json()).then(res => console.log(res));
    console.log(`file = ${params.get('file')}`);
});
*/
customElements.define('json-schema-editor', class extends HTMLElement {
    constructor() {
        super();
        const shadow = this.attachShadow({ mode: 'closed' });
        const editor = document.createElement('div');
        editor.classList.add('editor');
        this.getSchema().then((schema) => {
            this.render(editor, schema);
            shadow.appendChild(editor);
        });
    }

    getSchema() {
        const params = new URLSearchParams(location.search);
        return fetch(params.get('file')).then(res => res.json());
    }

    render(root, schema) {
        const { type, properties } = (schema || {});
        this.renderObject(root, properties);
    }

    renderObject(root, properties = {}) {
        return (Object.entries(properties) || []).map(([unique, options]) => {
            switch (options.type) {
                case 'array':
                case 'string':
                    root.appendChild(this.renderString(unique, options));
                case 'integer':
            }
        });
    }

    renderString(unique, options) {
        console.log('field', unique, options);
        const field = document.createElement('div');
        field.classList.add('field');
        const label = document.createElement('label');
        label.textContent = options.description || unique;
        field.appendChild(label);
        const value = document.createElement('div');
        value.classList.add('field-item');
        if (options.enum) {
            if (Array.isArray(options.enum)) {
                const select = document.createElement('select');
                options.enum.forEach((item, index) => {
                    const option = document.createElement('option');                    
                    option.textContent = item;
                    option.setAttribute('value', item);
                    option.setAttribute('data-index', index);
                    select.appendChild(option);
                });
                value.appendChild(select);
            }
        } else {
            const input = document.createElement('input');
            if (options.title) {
                input.setAttribute('title', options.title);
            }
            if (options.value) {
                input.setAttribute('value', options.value);
            }
            if (options.description) {
                input.setAttribute('placeholder', options.description);
            }
            value.appendChild(input);
        }

        field.appendChild(value);
        return field;
    }

    renderInteger() {

    }

    renderArray() {

    }

});