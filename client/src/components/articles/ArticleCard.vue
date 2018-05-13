<template>
  <div class="tb-article-card">
    <img :src="thumbnail" class="tb-article-card__thumbnail"/>
    <h2 class="tb-article-card__title">{{title}}</h2>
    <div class="tb-article-card__splitter">
      <span class="tb-article-card__splitter-line"/>
      <span class="tb-article-card__splitter-end"/>
    </div>
    <div class="tb-article-card__meta-data">{{date}} | {{placeName}}</div>
    <p class="tb-article-card__intro">{{intro}}</p>
  </div>
</template>

<script>
export default {
  props: {
    thumbnail: {type: String, required: true},
    title: {type: String, required: true},
    date: {type: String, required: true},
    placeName: {type: String, required: true},
    intro: {type: String, required: true}
  }
}
</script>

<style lang="sass">
  @import "src/assets/styles/main"

  .tb-article-card
    width: $article-width
    margin-bottom: $space-width

    &__thumbnail
      display: block
      width: 100%
      height: auto

    &__title
      color: $theme-color-1
      margin-bottom: 0

    &__splitter
      display: flex
      align-items: center
      margin-bottom: 15px

    &__splitter-line
      display: inline-block
      width: calc(100% - 9px)
      height: 0
      border-bottom: 1px solid $theme-color-1

    &__splitter-end
      display: inline-block
      float: right
      min-width: 9px
      height: 9px
      background-color: $theme-color-1

    &__meta-data
      color: $theme-color-1
</style>
