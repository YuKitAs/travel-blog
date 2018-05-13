<template>
  <div class="tb-featured-article">
    <img :src="thumbnail" class="tb-featured-article__thumbnail"/>
    <div class="tb-featured-article__info-card-anchor">
      <div class="tb-featured-article__info-card">
        <h2 class="tb-featured-article__title">{{title}}</h2>
        <div class="tb-featured-article__meta-data">{{date}} | {{placeName}}</div>
        <p class="tb-featured-article__intro">{{intro}}</p>
      </div>
    </div>
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

  .tb-featured-article
    width: 100%
    margin: 25px 0 $space-width 0

    &__thumbnail
      width: 100%
      max-height: auto

    &__title
      color: $theme-color-1-shaded-1
      margin-bottom: 0.5em

    &__meta-data
      color: $theme-color-1-shaded-1

    &__info-card-anchor
      height: 0

    &__info-card
      position: relative
      transform: translateY(-100%)
      top: -50px
      width: 55%
      padding: 1px 20px 1px 20px
      background: rgba(255, 255, 255, 0.8)
</style>
