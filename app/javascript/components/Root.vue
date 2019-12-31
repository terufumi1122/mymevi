<template>
  <div>
    <Header/>
    <Top/>
    <Footer/>
  </div>
</template>

<script>
import Top from "./Top";
import Header from "./Header";
import Footer from "./Footer";

export default {
  name: 'Root',
  components: {
    Header,
    Top,
    Footer,
  }
}
</script>

<style>
</style>