<template>
  <div class="tb-article" v-if="loaded">
    <h1 class="tb-article__title">{{article.title}}</h1>
    <div class="tb-article__meta-data">{{article.date | date}} | {{article.place.name}}</div>
    <div class="tb-article__tags">
      <a v-for="tag in article.tags" :key="tag.id" class="tb-article__tag">{{tag.name}}</a>
    </div>
    <hr/>
    <div class="tb-article__content" v-html="parsedContent"></div>
  </div>
</template>

<script>
import ArticleService from '@/services/ArticleService'
import PlaceService from '@/services/PlaceService'
import TagService from '@/services/TagService'

export default {
  props: {
    articleId: {type: String, required: true}
  },

  data() {
    return {
      article: null,
      loaded: false
    }
  },

  mounted() {
    this.loadData()
  },

  computed: {
    parsedContent() {
      return ArticleService.parseMarkdown(this.article.content)
    }
  },

  methods: {
    async loadData() {
      this.loaded = false

      try {
        this.article = (await ArticleService.getOne(this.articleId)).data
        this.article.place = (await PlaceService.getOne(this.article.place_id)).data
        this.article.tags = (await TagService.getByArticleId(this.articleId)).data
      } catch (e) {
        this.$router.push({name: 'Error'})
      }

      this.loaded = true
    }
  }
}
</script>

<style lang="sass">
  @import "src/assets/styles/main"

  .tb-article
    &__meta-data
      font-size: 0.9rem
      font-style: italic
      color: $dark-text-color-highlighted

    &__tags
      margin-top: 1rem

    &__tag
      display: inline-block
      font-size: 0.9rem
      color: $light-text-color-grey
      background-color: $dark-background-color-highlighted
      padding: 0.2rem 0.5rem 0.2rem 0.5rem
      margin-right: 0.2rem
      border-radius: 0.25rem
</style>
