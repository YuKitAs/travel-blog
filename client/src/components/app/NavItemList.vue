<template>
  <ul class="tb-nav-item-list">
    <li v-for="navItem in navItems" :key="navItem">
      <span class="tb-nav-item-list__text"
          :class="{'tb-nav-item-list__text--activated': navItemActivated(navItem)}"
          @click="navigateTo(navItem)">{{capitalized(navItem)}}</span>
    </li>
  </ul>
</template>

<script>
import _ from 'lodash'

export default {
  data() {
    return {
      navItems: ['Articles', 'About']
    }
  },

  methods: {
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

  .tb-nav-item-list
    padding: 0
    margin: 7px 0 7px 0
    text-align: center
    list-style-type: none

    &__text
      display: inline-block
      padding: 6px 0 4px 0
      color: $theme-color-2
      font-size: 120%
      cursor: pointer

      &:hover
        color: $theme-color-1

      &--activated
        color: $theme-color-1
        cursor: default
</style>
