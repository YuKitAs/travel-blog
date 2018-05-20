<template>
  <div class="tb-photo-frame">
    <img :src="photoUrl" class="tb-photo"/>
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
    width: 100%
    height: auto
    transition: 0.5s
    &:hover
      transform: scale(1.05, 1.05)
</style>
