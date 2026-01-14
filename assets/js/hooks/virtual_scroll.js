// VirtualScroll Hook for efficient rendering of large lists
export const VirtualScroll = {
    mounted() {
        this.container = this.el
        this.itemHeight = parseInt(this.el.dataset.itemHeight) || 80
        this.throttleTimeout = null

        this.handleScroll = () => {
            if (this.throttleTimeout) {
                clearTimeout(this.throttleTimeout)
            }

            this.throttleTimeout = setTimeout(() => {
                this.pushEvent("scroll", {
                    scrollTop: this.container.scrollTop.toString()
                })
            }, 16) // ~60fps
        }

        this.container.addEventListener('scroll', this.handleScroll)
    },

    destroyed() {
        if (this.container) {
            this.container.removeEventListener('scroll', this.handleScroll)
        }
        if (this.throttleTimeout) {
            clearTimeout(this.throttleTimeout)
        }
    }
}
