<template>
  <div style="margin-top: 30px">
    <div class="footer_line">
    </div>
    <div class="footer">
      <v-footer padless>
        <v-card
          flat
          tile
          class="white--text text-center" 
          width="100%"
          color="#6699FF"
        >
          <v-card-text>
            <v-btn
              v-for="menu in icons" :key="menu.icon" :href="menu.href"
              class="mx-4 white--text"
              icon
              target="_blank"
            >
              <v-icon size="24px">
                {{ menu.icon }}
              </v-icon>
            </v-btn>
          </v-card-text>

          <v-card-text class="white--text pt-0">
            블라블라<br>
            블라블라
          </v-card-text>

          <v-divider></v-divider>

          <v-card-text class="white--text pt-0 pb-6" style="font-size: 1px; height: 5px;">
            © NEXT-PAGE Corp.
          </v-card-text>
        </v-card>
      </v-footer>
    </div>
  </div>
  
</template>

<script>

export default {
  name: "FooterMenuForm",
  data() {
    return {
      icons: [
        { icon: 'mdi-facebook', href: 'https://ko-kr.facebook.com/facebook/'},
        { icon: 'mdi-twitter', href: 'https://twitter.com/'},
        { icon: 'mdi-instagram', href: 'https://www.instagram.com/' },
      ],
      padless: true,
      
      
    
    }
  }
}
</script>

<style scoped>

.footer {
  margin-left: 120px;
  margin-right: 120px;  
  height : 100%
}

.footer_line {
  border-bottom: 1px solid #f0f0f0;
}


</style>