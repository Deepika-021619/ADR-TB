class SystemMapper {
  // Questionnaire name → DB ENUM value
  static String getSystemEnum(String questionnaireName) {
    switch (questionnaireName.toUpperCase()) {
      case 'RESPIRATORY SYSTEM':
        return 'Respiratory';  // DB ENUM value 1
      case 'GASTROINTESTINAL SYSTEM': 
        return 'Gastrointestinal';  // DB ENUM value 2
      case 'CENTRAL NERVOUS SYSTEM':
        return 'Centralnervous';  // DB ENUM value 3
      case 'OCULAR INVOLVEMENT':
        return 'Ocular';  // DB ENUM value 9
      case 'SKIN AND SUBCUTANEOUS TISSUE RELATED SYMPTOMS':
        return 'SkinSubcutaneous';  // DB ENUM value 2
      case 'PSYCHIATRIC':
        return 'Psychiatric';  // DB ENUM value 2  
      case 'MUSCULOSKELETAL':
        return 'Musculoskeletal';  // DB ENUM value 4
      case 'GENITOURINARY':
        return 'Genitourinary';  // Map as needed
      case 'GENERAL NONSPECIFIC SYMPTOMS':
        return 'General';  // DB ENUM value 10
      case 'CARDIOVASCULAR SYSTEM':
        return 'Cardiovascular';  // DB ENUM value 1 for sld 
      default:
        return 'General';
    }
  }
}
