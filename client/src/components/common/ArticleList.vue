<template>
  <div class="tb-article-list" ref="columns">
    <div ref="column" v-for="(column, index) in columns" :key="index" class="tb-column">
      <article-card v-for="articlePreview in column" :key="articlePreview.id" :article-preview="articlePreview"/>
    </div>
  </div>
</template>

<script>
import _ from 'lodash'
import ArticleCard from '@/components/common/ArticleCard'

const ARTICLE_WIDTH = 300
const SPACE_WIDTH = 50

export default {
  props: {
    articlePreviews: {type: Array, default: () => []}
  },

  data() {
    return {
      columns: []
    }
  },

  watch: {
    articlePreviews(articlePreviews) {
      this.rearrangeArticles(articlePreviews)
    }
  },

  methods: {
    rearrangeArticles(notArrangedArticles) {
      this.columns = []

      let numberOfColumns = this.calculateNumberOfColumns()
      for (let i = 0; i < numberOfColumns; i += 1) {
        this.columns.push([])
      }

      this.$nextTick(() => {
        notArrangedArticles.forEach(notArrangedArticle => {
          this.columns[this.getIndexOfShortestColumn()].push(notArrangedArticle)
        })
      })
    },

    getIndexOfShortestColumn() {
      let heights = this.columns.map((articles, index) => _.get(this.$refs.column, [index, 'scrollHeight'], 0))
      let minHeight = Math.min(...heights)

      console.log(`heights: [${heights.join(',')}]`)
      console.log(`minHeight: ${minHeight}`)

      return heights.indexOf(minHeight)
    },

    calculateNumberOfColumns() {
      return (this.$refs.columns.offsetWidth + SPACE_WIDTH) / (ARTICLE_WIDTH + SPACE_WIDTH)
    }
  },

  components: {
    ArticleCard
  }
}
</script>

<style lang="sass" scoped>
  @import "src/assets/styles/mixins"

  .tb-article-list
    display: flex
    align-items: flex-start
    justify-content: space-between

  .tb-column
    width: 300px
</style>
