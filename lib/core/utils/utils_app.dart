class UtilsApp {

    static String getPokemonStats(String stat) {
      switch (stat.toLowerCase()) {
        case "hp":
          return "HP";
        case "attack":
          return "ATK";
        case "defense":
          return "DEF";
        case "special-attack":
          return "SATK";
        case "special-defense":
          return "SDEF";
        case "speed":
          return "SPD";
        default:
          return "STAT"; 
      }
    }

  static String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text
        .split(" ")
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(" ");
  }    


}