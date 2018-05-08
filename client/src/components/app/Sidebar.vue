<template>
  <div class="tb-sidebar" ref="sidebar" :style="dynamicMarginTop()">
    <div class="tb-sidebar__vertical-line-top"/>
    <img :src="require('@/assets/images/logo.png')" class="tb-sidebar__logo"/>
    <h1 class="tb-sidebar__website-title">Captain<br/>Bonbon</h1>
    <div class="tb-sidebar__vertical-line-middle-end"/>
    <div class="tb-sidebar__vertical-line-middle"/>
    <nav-item-list/>
    <div class="tb-sidebar__vertical-line-bottom"/>
    <hamburger-button :expanded="expanded" @toggle="toggleExpanded"/>
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
    setTimeout(() => {
      this.$forceUpdate()
    }, 0)
  },

  methods: {
    toggleExpanded() {
      if (this.$refs.sidebar.style.transition === '') {
        this.$refs.sidebar.style.transition = '0.5s'
      }

      this.expanded = !this.expanded
    },

    dynamicMarginTop() {
      if (!this.$refs.sidebar) {
        return {marginTop: '0'}
      }
      return this.expanded ? {marginTop: '0'} : {marginTop: `${55 - this.$refs.sidebar.offsetHeight}px`}
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

    &__website-title
      text-align: center
      margin: 5px 0 5px 0
      color: $theme-color-1

    &__vertical-line-top, &__vertical-line-middle, &__vertical-line-bottom
      width: 0
      border-left: 1px solid $theme-color-1

    &__vertical-line-top, &__vertical-line-middle
      height: 25px

    &__vertical-line-bottom
      height: 35px

    &__vertical-line-middle-end
      width: 9px
      height: 9px
      background-color: $theme-color-1

    &__logo
      width: 120px
      height: auto
</style>
