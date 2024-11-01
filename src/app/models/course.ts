import { TypeCourse } from './type-course'; // Modèle pour TypeCourse
import { Support } from './support'; // Modèle pour Support

export class Course {
  numCourse?: number; // ID du cours (numCourse)
  level: number; // Niveau du cours
  typeCourse: TypeCourse; // Type de cours (enums)
  support: Support; // Support (enums)
  price: number; // Prix
  timeSlot: number; // Créneau horaire

  constructor() {
    this.level = 1; // valeur par défaut
    this.typeCourse = TypeCourse.COLLECTIVE_CHILDREN; // valeur par défaut
    this.support = Support.SKI; // valeur par défaut
    this.price = 0; // valeur par défaut
    this.timeSlot = 0; // valeur par défaut
  }
}
