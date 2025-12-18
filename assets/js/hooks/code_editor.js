import { EditorView, basicSetup } from "codemirror"
import { EditorState } from "@codemirror/state"
import { elixir } from "codemirror-lang-elixir"
import { oneDark } from "@codemirror/theme-one-dark"

export default {
    mounted() {
        this.timer = null
        this.initEditor()
    },

    updated() {
        // Optional: Handle updates from server if needed
    },

    initEditor() {
        const initialContent = this.el.dataset.content
        const isReadOnly = this.el.dataset.readOnly === "true"

        this.editor = new EditorView({
            state: EditorState.create({
                doc: initialContent,
                extensions: [
                    basicSetup,
                    elixir(),
                    oneDark,
                    EditorState.readOnly.of(isReadOnly),
                    EditorView.updateListener.of((update) => {
                        if (update.docChanged && !isReadOnly) {
                            clearTimeout(this.timer)
                            this.timer = setTimeout(() => {
                                this.pushEventTo(this.el, "save_source", {
                                    source: update.state.doc.toString()
                                })
                            }, 2000)
                        }
                    })
                ]
            }),
            parent: this.el
        })
    }
}
