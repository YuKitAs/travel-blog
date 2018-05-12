<template>
  <div ref="main-menu" class="tb-main-menu">
    <div class="tb-main-menu__vertical-line-top"/>
    <img :src="require('@/assets/images/logo.png')" class="tb-main-menu__logo"/>
    <h1 class="tb-main-menu__website-title">Captain<br/>Bonbon</h1>
    <div class="tb-main-menu__vertical-line-middle-end"/>
    <div class="tb-main-menu__vertical-line-middle"/>
    <nav-item-list/>
    <div class="tb-main-menu__vertical-line-bottom"/>
    <hamburger-button ref="hamburger-button" :expanded="expanded" @toggle="toggleExpanded"
        class="tb-main-menu__hamburger-button"/>
  </div>
</template>

<script>
import HamburgerButton from '@/components/app/HamburgerButton'
import NavItemList from '@/components/app/NavItemList'

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
      const isWideScreen = this.$refs['hamburger-button'].$el.offsetHeight === 0
      const remainHeight = 55
      const calculatedHeight = this.$refs['main-menu'].offsetHeight

      this.$refs['main-menu'].style.marginTop =
        (isWideScreen || this.expanded) ? '0' : `${remainHeight - calculatedHeight}px`
    }
  },

  components: {
    HamburgerButton,
    NavItemList
  }
}
</script>

<style lang="sass">
  @import "src/assets/styles/main"

  .tb-main-menu
    display: flex
    flex-direction: column
    align-items: center
    @include page-width('medium-and-up')
      height: 100vh
      overflow: hidden

    &__website-title
      text-align: center
      margin: 5px 0 5px 0
      color: $theme-color-1

    &__vertical-line-top, &__vertical-line-middle, &__vertical-line-bottom
      width: 0
      border-left: 1px solid $theme-color-1

    &__vertical-line-top, &__vertical-line-middle
      min-height: 25px

    &__vertical-line-bottom
      min-height: 35px
      @include page-width('medium-and-up')
        min-height: 100%

    &__vertical-line-middle-end
      width: 9px
      min-height: 9px
      background-color: $theme-color-1

    &__logo
      width: 120px
      height: auto

    &__hamburger-button
      @include page-width('medium-and-up')
        display: none
</style>
