<template>
  <div>
    <router-link :to="{name: 'Articles.Article', params: {articleId: 'dbc5e11c-0f89-45b3-8f89-3cf53f9f5458'}}">Test Article</router-link>
    <router-link :to="{name: 'Articles.Article', params: {articleId: 'does-not-exist'}}">Error Article</router-link>
  </div>
</template>
