<template>
  <div class="tb-sidebar" ref="sidebar" :style="dynamicStyle">
    <div class="tb-sidebar__vertical-line-top"/>
    <img :src="require('@/assets/images/logo.png')" class="tb-sidebar__logo"/>
    <h1 class="tb-sidebar__website-title">Captain<br/>Bonbon</h1>
    <div class="tb-sidebar__vertical-line-middle-end"/>
    <div class="tb-sidebar__vertical-line-middle"/>
    <nav-item-list/>
    <div class="tb-sidebar__vertical-line-bottom"/>
    <hamburger-button :expanded="expanded" @toggle="toggleExpanded" class="tb-sidebar__hamburger-button"/>
  </div>
</template>

<script>
import _ from 'lodash'
import HamburgerButton from '@/components/app/HamburgerButton'
import NavItemList from '@/components/app/NavItemList'

export default {
  data() {
    return {
      expanded: false,
      dynamicStyle: {marginTop: '0'}
    }
  },

  mounted() {
    setTimeout(this.updateMarginTop, 0)
    addEventListener('resize', _.debounce(this.updateMarginTop, 200))
  },

  methods: {
    toggleExpanded() {
      // Only apply transition when needed
      if (this.$refs.sidebar.style.transition === '') {
        this.$refs.sidebar.style.transition = '0.5s'

        setTimeout(() => {
          this.$refs.sidebar.style.transition = ''
        }, 500)
      }

      this.expanded = !this.expanded

      this.updateMarginTop()
    },

    updateMarginTop() {
      this.dynamicStyle = (window.innerWidth >= 600 || this.expanded)
        ? {marginTop: '0'}
        : {marginTop: `${55 - this.$refs.sidebar.offsetHeight}px`}
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

  .tb-sidebar
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
