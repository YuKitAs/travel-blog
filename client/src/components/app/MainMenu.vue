<template>
  <div ref="main-menu" class="tb-main-menu">
    <div class="tb-vertical-line tb-line-top"/>
    <img :src="require('@/assets/images/logo.png')" class="tb-logo"/>
    <h1 class="tb-website-title">Captain<br/>Bonbon</h1>
    <div class="tb-line-head"/>
    <div class="tb-vertical-line tb-line-middle"/>
    <nav-item-list/>
    <div class="tb-vertical-line tb-line-bottom"/>
    <hamburger-button ref="hamburger-button" :expanded="expanded" @toggle="toggleExpanded"
        class="tb-hamburger-button-visible-mask"/>
  </div>
</template>

<script>
import HamburgerButton from '@/components/app/HamburgerButton'
import NavItemList from '@/components/app/NavItemList'
import Responsive from '@/services/Responsive'

export default {
  data() {
    return {
      expanded: false
    }
  },

  mounted() {
    setTimeout(this.updateMarginTop, 0)
    addEventListener('resize', this.updateMarginTop)
  },

  watch: {
    '$route'() {
      if (this.expanded) {
        this.toggleExpanded()
      }
    }
  },

  methods: {
    toggleExpanded() {
      // Only apply transition when needed
      if (this.$refs['main-menu'].style.transition === '') {
        this.$refs['main-menu'].style.transition = '0.5s'

        setTimeout(() => {
          this.$refs['main-menu'].style.transition = ''
        }, 500)
      }

      this.expanded = !this.expanded

      this.updateMarginTop()
    },

    updateMarginTop() {
      this.$refs['main-menu'].style.marginTop =
        (Responsive.MEDIUM_AND_UP || this.expanded) ? '0' : `${55 - this.$refs['main-menu'].offsetHeight}px`
    }
  },

  components: {
    HamburgerButton,
    NavItemList
  }
}
</script>

<style lang="sass" scoped>
  @import "src/assets/styles/mixins"

  .tb-main-menu
    display: flex
    flex-direction: column
    align-items: center
    @include page-width('medium-and-up')
      height: 100vh
      overflow: hidden

  .tb-website-title
      text-align: center
      margin: 5px 0 5px 0

  .tb-line-top, .tb-line-middle
    min-height: 25px

  .tb-line-bottom
      min-height: 35px
      @include page-width('medium-and-up')
        min-height: 100%

  .tb-logo
      width: 120px
      height: auto

  .tb-hamburger-button-visible-mask
    @include page-width('medium-and-up')
      display: none
</style>
