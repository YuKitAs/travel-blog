<template>
  <div class="tb-photo-frame">
    <img :src="photoUrl"
      class="tb-photo"
      :class="{'tb-photo--fullsized': !isThumbnail, 'tb-photo--thumbnail': isThumbnail}"
      @click="$emit('click')"/>
  </div>
</template>

<script>
export default {
  props: {
    imageId: {type: String, required: true},
    isThumbnail: {type: Boolean, default: false}
  },

  computed: {
    photoUrl() {
      return `/api/images/${this.imageId}${this.isThumbnail ? '/thumbnail' : ''}`
    }
  }
}
</script>

<style lang="sass" scoped>
  @import "src/assets/styles/mixins"

  .tb-photo-frame
    overflow: hidden

  .tb-photo
    display: block
    text-align: center
    width: 100%
    height: auto
    transition: $transition-time

  .tb-photo--fullsized
    &:hover
      transform: scale(1.02, 1.02)

  .tb-photo--thumbnail
    &:hover
      transform: scale(1.03, 1.03)
</style>
