<template>
  <div class="tb-hamburger-button" @click="toggle">
    <div class="tb-hamburger-button__strip" :class="{'tb-hamburger-button__strip--expanded': expanded}"/>
    <div class="tb-hamburger-button__strip" :class="{'tb-hamburger-button__strip--expanded': expanded}"/>
    <div class="tb-hamburger-button__strip" :class="{'tb-hamburger-button__strip--expanded': expanded}"/>
  </div>
</template>

<script>
export default {
  props: {
    expanded: {type: Boolean, default: false}
  },

  methods: {
    toggle() {
      this.$emit('toggle')
    }
  }
}
</script>

<style lang="sass">
  @import "src/assets/styles/main"

  .tb-hamburger-button
    width: 30px
    height: 25px
    padding: 7.5px 5px 7.5px 5px
    background-color: $theme-color-1
    cursor: pointer

    &__strip
      width: 30px
      height: 5px
      background-color: $theme-color-3
      transition: 0.35s linear
      border-radius: 2px

      &:nth-child(2)
        margin-top: 5px
        margin-bottom: 5px

      &--expanded
        &:nth-child(1)
          transform: translateY(10px) rotate(45deg)

        &:nth-child(3)
          transform: translateY(-10px) rotate(-45deg)

        &:nth-child(2)
          width: 0
          opacity: 0
</style>
