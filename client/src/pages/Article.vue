<template>
  <div class="tb-article" v-if="loaded">
    <h1 class="tb-article__title">{{article.title}}</h1>
    <div class="tb-article__meta-data">{{article.date | date}} | {{article.place.name}}</div>
    <hr/>
    <div class="tb-article__content" v-html="parsedContent"></div>
  </div>
</template>

<script>
import ArticleService from '@/services/ArticleService'
import PlaceService from '@/services/PlaceService'

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
      color: #999999
</style>
