<template>
  <div id="app">
    <router-view class="container" />
  </div>
</template>

<script>
export default {
  props: {

  },
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  created() {
    
  }
}
</script>

<style scoped >
p {
  font-size: 2em;
  text-align: center;
}
</style>
