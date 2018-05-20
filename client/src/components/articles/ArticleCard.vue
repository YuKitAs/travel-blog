<template>
  <div class="tb-article-card" @click="$emit('click')">
    <div class="tb-thumbnail-container">
      <img :src="thumbnailUrl" class="tb-thumbnail"/>
    </div>
    <h2 class="tb-title">{{title}}</h2>
    <div class="tb-splitter">
      <span class="tb-horizontal-line tb-splitter-line"/>
      <span class="tb-line-head"/>
    </div>
    <div class="tb-meta-data">{{date}} | {{placeName}}</div>
    <p class="tb-introduction">{{introduction}}</p>
  </div>
</template>

<script>
export default {
  props: {
    thumbnail: {type: String, required: true},
    title: {type: String, required: true},
    date: {type: String, required: true},
    placeName: {type: String, required: true},
    introduction: {type: String, required: true}
  },

  computed: {
    thumbnailUrl() {
      return `/api/images/${this.thumbnail}/thumbnail`
    }
  }
}
</script>

<style lang="sass" scoped>
  @import "src/assets/styles/mixins"

  .tb-article-card
    width: $article-width
    margin-bottom: $space-width

    &:hover
      cursor: pointer

  .tb-thumbnail-container
    overflow: hidden

  .tb-thumbnail
    display: block
    width: 100%
    height: auto
    transition: 0.5s

    &:hover
      transform: scale(1.05, 1.05)

  .tb-title
    color: $theme-color-1
    margin-bottom: 0

  .tb-splitter
    display: flex
    align-items: center
    margin-bottom: 15px

  .tb-splitter-line
    display: inline-block
    width: calc(100% - 9px)
    height: 0
    border-bottom: 1px solid $theme-color-1

  .tb-meta-data
    color: $theme-color-1
</style>
