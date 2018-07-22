<template>
  <div id="app">
    <div class="row">
      <b-nav vertical class="d-none d-md-block col-md-3 col-lg-2 pt-1 bg-light sidebar">
        <b-nav-item disabled><font-awesome-icon class="icon" icon="file-image" fixed-width />Articles</b-nav-item>
        <b-nav-item disabled><font-awesome-icon class="icon" icon="map-marked-alt" fixed-width />Places</b-nav-item>
        <b-nav-item><font-awesome-icon class="icon" icon="tag" fixed-width />Tags</b-nav-item>
      </b-nav>
      <div class="col-12 col-md-9 ml-sm-auto col-lg-10 pt-3">
        <tags/>
      </div>
    </div>
  </div>
</template>

<script>
import Tags from '@/components/Tags'

export default {
  name: 'App',
  components: {
    Tags
  }
}
</script>

<style scoped>
.sidebar {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  box-shadow: inset -2px 0 6px 0 rgba(0.5, 0.5, 0.5, 0.1);
}

.icon {
  margin-right: 10px;
}
</style>
