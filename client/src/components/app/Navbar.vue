<template>
  <ul class="tb-navbar">
    <li v-for="navItem in navItems" :key="navItem"
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
import _ from 'lodash';

export default {
  name: 'Navbar',

  data() {
    return {
      navItems: ['About', 'Articles', 'Places', 'Timeline'],
    };
  },

  methods: {
    imagePath(navItem) {
      // eslint-disable-next-line
      return require(`@/assets/images/icon-${_.kebabCase(navItem)}.png`);
    },

    capitalized(navItem) {
      return _.startCase(navItem);
    },

    navItemActivated(navItem) {
      return this.$route.name === navItem;
    },
  },
};
</script>

<style lang="sass">
  @import "src/assets/styles/main"

  @keyframes item-hover-animation
    from
      padding-left: 0
    to
      padding-left: 0.5rem

  .tb-navbar
    list-style-type: none
    padding: 1rem 0 0 2.2rem

    &__item
      @include make-row
      align-items: center
      color: $light-text-color
      cursor: pointer
      padding-bottom: 1px

      &:hover
        animation-name: item-hover-animation
        animation-duration: 0.5s
        animation-fill-mode: forwards

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
