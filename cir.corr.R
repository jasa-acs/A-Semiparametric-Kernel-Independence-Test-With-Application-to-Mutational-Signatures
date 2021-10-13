Unknown <- paste0("SBS", c(5, 8, 12, 16, "17a", "17b", 19, 23, 28, 33, 34, 37, 39, 40, 41))
Known <- paste0("SBS", c(1:4, 6, "7a", "7b", "7c", "7d", 9, "10a", "10b", 11, 13:15, 18, 20, 21, 22, 24:26, 29:32, 35, 36, 38, 42:44))
gl <- list(Known, Unknown)
names(gl) <- c("Known", "Unknown")
n_group <- length(gl)
group_size <- sapply(gl, length)
group_color <- structure(c("#796878", "#006d2c"), names = names(gl))
Turnoff_color <- structure(c("#a99aa8", "#74c476"), names = names(gl))
#group_font <- structure(c("Times", "Helvetica"), names = names(gl))
group_font <- structure(c("serif", "sans"), names = names(gl))
gd <- structure(rep(names(gl), times = sapply(gl, length)), names = unlist(gl))
RN <- c(Known, Unknown)
cir.corr <- function(Type = c("Colo", "Eso", "Stom")){
  
  v_i = NULL
  v_j = NULL
  v_g1 = NULL
  v_g2 = NULL
  v_k1 = NULL
  v_k2 = NULL
  v = NULL
  for(i in 1:length(RN)) {
    for(j in 1:length(RN)) {
      if(Type == "Colo") tmp.p <- Skit_Colo_FDR[Skit_Colo_FDR$Sig1 == RN[i] & Skit_Colo_FDR$Sig2 == RN[j], "BH"]
      if(Type == "Eso") tmp.p <- Skit_Eso_FDR[Skit_Eso_FDR$Sig1 == RN[i] & Skit_Eso_FDR$Sig2 == RN[j], "BH"]
      if(Type == "Stom") tmp.p <- Skit_Stom_FDR[Skit_Stom_FDR$Sig1 == RN[i] & Skit_Stom_FDR$Sig2 == RN[j], "BH"]
      if(length(tmp.p) > 0){
        if(tmp.p <= 0.05){
          g1 = gd[RN[i]]
          g2 = gd[RN[j]]
          r1 = gd[gd == g1]
          k1 = which(names(r1) == RN[i]) - 0.5
          r2 = gd[gd == g2]
          k2 = which(names(r2) == RN[j]) - 0.5
          
          v_i = c(v_i, i)
          v_j = c(v_j, j)
          v_g1 = c(v_g1, g1)
          v_g2 = c(v_g2, g2)
          v_k1 = c(v_k1, k1)
          v_k2 = c(v_k2, k2)
          v = c(v, -log(tmp.p, 10))
        }
      }
    }
  }
  df = data.frame(i = v_i, j = v_j, g1 = v_g1, g2 = v_g2, k1 = v_k1, k2 = v_k2, v = v)
  df = df[order(abs(df$v)), ]
  df <- df[!(df$i %in% which(RN %in% c("SBS1", "SBS5", "SBS40")) | df$j %in% which(RN %in% c("SBS1", "SBS5", "SBS40"))),]

  circos.par(canvas.ylim=c(-1.2,1.2), # edit  canvas size 
             gap.after = c(8, 8), # adjust gaps between regions
             track.margin = c(0.01, 0)) # adjust bottom and top margin 

  if(Type == "Colo") Ons <- unique(unlist(Skit_Colo_FDR[,1:2]))
  if(Type == "Eso") Ons <- unique(unlist(Skit_Eso_FDR[,1:2]))
  if(Type == "Stom") Ons <- unique(unlist(Skit_Stom_FDR[,1:2]))
  
  
  circos.initialize(names(gl), xlim = cbind(rep(0, n_group), group_size))
  circos.trackPlotRegion(ylim = c(0, 1), panel.fun = function(x, y) {
    nm = get.cell.meta.data("sector.index")
    r = gl[[nm]]
    n = length(r)
    for(i in 1:n){
      if(r[i] %in% Ons){
        circos.text(i - 0.7, 0, r[i], facing = "clockwise", niceFacing = TRUE, cex = 1.1, adj = c(0, 1), col = group_color[nm], font = 2, family = group_font[nm])
      } else{
        circos.text(i - 0.7, 0, r[i], facing = "clockwise", niceFacing = TRUE, cex = 1, adj = c(0, 1), col = Turnoff_color[nm], family = group_font[nm])
      }
    }
  }, bg.border = NA, track.height = 0.1)
  
  idx_17 <- which(df$i %in% c(2,14) & df$j %in% 38:39) ## 17 and APOBEC
  idx_sp <- seq_len(nrow(df))[-idx_17] ## cancer-specific
  
  for(k in idx_sp) circos.link(df$g1[k], df$k1[k], df$g2[k], df$k2[k], col = "#2166ac", h.ratio = 0.7, lwd = df$v[k]/2, lty = 2) #fdbb84
  for(k in idx_17) circos.link(df$g1[k], df$k1[k], df$g2[k], df$k2[k], col = "#b2182b", h.ratio = 0.7, lwd = df$v[k]/2, lty = 1) #b30000

  if(Type == "Colo") title("(a) Colorectal", adj = 0, line = -1, cex.main = 1.1)
  if(Type == "Eso") title("(b) Esophageal", adj = 0, line = -1, cex.main = 1.1)
  if(Type == "Stom") title("(c) Stomach", adj = 0, line = -1, cex.main = 1.1)
  
  circos.clear()
}