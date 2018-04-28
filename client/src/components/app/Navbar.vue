<template>
  <ul class="tb-navbar">
    <li v-for="navItem in navItems" :key="navItem" @click="navigateTo(navItem)"
        class="tb-navbar__item"
        :class="{'tb-navbar__item--activated': navItemActivated(navItem)}">
      <img :src="imagePath(navItem)"
          class="tb-navbar__icon"
          :class="{'tb-navbar__icon--activated': navItemActivated(navItem)}">
      <span class="tb-navbar__text">{{capitalized(navItem)}}</span>
    </li>
  </ul>
</template>

<script>
import _ from 'lodash'

export default {
  data() {
    return {
      navItems: ['Articles', 'Places', 'Timeline', 'About']
    }
  },

  methods: {
    imagePath(navItem) {
      // eslint-disable-next-line
      return require(`@/assets/images/icon-${_.kebabCase(navItem)}.png`)
    },

    capitalized(navItem) {
      return _.startCase(navItem)
    },

    navItemActivated(navItem) {
      return this.$route.name.includes(navItem)
    },

    navigateTo(navItem) {
      this.$router.push({name: navItem})
    }
  }
}
</script>

<style lang="sass">
  @import "src/assets/styles/main"

  .tb-navbar
    list-style-type: none
    padding: 0.5rem 0 0 2.2rem

    &__item
      @include make-row
      align-items: center
      color: $light-text-color
      cursor: pointer
      padding: 0 0 1px 0.5rem
      transition: background-color 0.5s

      &:hover
        background-color: $dark-background-color-highlighted

      &--activated
        color: $light-text-color-highlighted
        padding-bottom: 0
        border-style: solid
        border-width: 0 0 1px 0
        border-color: $light-text-color-highlighted

    &__text
      padding-left: 0.5rem

    &__icon
      height: 1.8rem

      &--activated
        filter: brightness(122%) saturate(33%)
</style>
