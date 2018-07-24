<template>
  <div id="admin-home">
    <div class="title">Welcome to Captain's Cabin</div>
    <div>
      <img class="bonbon static" :src="require('@/assets/bonbon-static.png')"/>
      <img class="bonbon" :src="require('@/assets/bonbon.gif')"/>
    </div>
  </div>
</template>

<script>
export default {
  name: 'AdminHome'
}
</script>

<style scoped>
#admin-home {
  text-align: center;
}

.title {
  margin: 50px auto;
  color: #4d4d4d;
  font-size: 50px;
}

.bonbon {
  width: 250px;
  height: 250px;
}

.static {
  position: absolute;
  background: white;
}

.static:hover {
  opacity: 0;
}
</style>
