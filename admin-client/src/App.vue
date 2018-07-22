<template>
  <div id="app">
    <b-nav vertical class="col-md-2 bg-light sidebar">
      <b-nav-item disabled><font-awesome-icon class="icon" icon="file-image" fixed-width />Articles</b-nav-item>
      <b-nav-item disabled><font-awesome-icon class="icon" icon="map-marked-alt" fixed-width />Places</b-nav-item>
      <b-nav-item><font-awesome-icon class="icon" icon="tag" fixed-width />Tags</b-nav-item>
    </b-nav>
    <div class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
      <tags/>
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

<style>
.sidebar {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  z-index: 100;
  padding: 0;
  box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
}

.bg-light {
  background-color: #f8f9fa!important;
}

.col-md-2 {
  flex: 0 0 16.666667%;
  max-width: 16.666667%;
}

.icon {
  margin-right: 10px;
}
</style>
