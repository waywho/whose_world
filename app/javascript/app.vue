<template>
  <div id="app">
    <router-view></router-view>
    <p>{{ message }}</p>
    <div class="bg-red-500 p-3 text-white">Test</div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped >
p {
  font-size: 2em;
  text-align: center;
}
</style>
