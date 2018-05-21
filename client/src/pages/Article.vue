<template>
  <div class="tb-article" v-if="loaded">
    <h1 class="tb-page-title">{{article.title}}</h1>
    <metadata :date="article.date" :place="article.place" :tags="article.tags"/>
    <hr/>
    <div class="tb-page-content" :inner-html.prop="article.content | markdown"></div>
  </div>
</template>

<script>
import Metadata from '@/components/common/Metadata'

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

  methods: {
    async loadData() {
      this.loaded = false

      try {
        this.article = (await ArticleService.getOne(this.articleId)).data
        this.article.place = (await PlaceService.getOne(this.article.place_id)).data
        this.article.tags = (await TagService.getByArticleId(this.articleId)).data
      } catch (e) {
        this.$router.replace({name: 'Error'})
      }

      this.loaded = true
    }
  },

  components: {
    Metadata
  }
}
</script>

<style lang="sass">
  @import "src/assets/styles/mixins"

  img[alt="portrait"]
    display: block
    width: 100%
    height: auto
    margin: 0 auto
    @include page-width("large-and-up")
      width: 50%

  img[alt="landscape"]
    display: block
    width: 105%
    height: auto
    margin: 0 auto
    @include page-width("large-and-up")
      width: 75%
</style>
