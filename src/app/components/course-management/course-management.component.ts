import { Component, OnInit } from '@angular/core';
import { CourseService } from '../../services/course.service';
import { Course } from '../../models/course';
import { TypeCourse } from '../../models/type-course';
import { Support } from '../../models/support';

@Component({
  selector: 'app-course-management',
  templateUrl: './course-management.component.html',
  styleUrls: ['./course-management.component.css']
})
export class CourseManagementComponent implements OnInit {
  courses: Course[] = [];
  course: Course = { level: 1, typeCourse: TypeCourse.COLLECTIVE_CHILDREN, support: Support.SKI, price: 0, timeSlot: 0 };

  constructor(private courseService: CourseService) { }

  ngOnInit(): void {
    this.retrieveCourses();
  }

  retrieveCourses(): void {
    this.courseService.getAllCourses().subscribe(data => {
      this.courses = data;
      this.updateCourseLevel();
    });
  }

  updateCourseLevel(): void {
    // Find the maximum level and set the level for the new course
    if (this.courses.length > 0) {
      this.course.level = Math.max(...this.courses.map(c => c.level)) + 1;
    } else {
      this.course.level = 1; // Start from level 1 if no courses exist
    }
  }

  addCourse(): void {
    this.courseService.addCourse(this.course).subscribe(() => {
      this.retrieveCourses();
      this.resetCourse();
    });
  }

  updateCourse(course: Course): void {
    this.course = { ...course }; // Populate the form with selected course data
  }

  saveUpdatedCourse(): void {
    this.courseService.updateCourse(this.course).subscribe(() => {
      this.retrieveCourses();
      this.resetCourse();
    });
  }

 deleteCourse(numCourse: number): void {
    if (confirm('Êtes-vous sûr de vouloir supprimer ce cours ?')) { // Confirmation dialog
        this.courseService.deleteCourse(numCourse).subscribe(
            () => {
                this.retrieveCourses(); // Rafraîchir la liste après suppression
            },
            (error) => {
                console.error('Erreur lors de la suppression du cours', error);
                alert('Une erreur est survenue lors de la suppression du cours.');
            }
        );
    }
}

  resetCourse(): void {
    this.course = { level: 1, typeCourse: TypeCourse.COLLECTIVE_CHILDREN, support: Support.SKI, price: 0, timeSlot: 0 };
  }
}
