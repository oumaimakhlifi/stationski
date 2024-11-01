import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Course } from '../models/course'; // Importez le modèle Course

@Injectable({
  providedIn: 'root'
})
export class CourseService {

  private baseUrl = 'http://localhost:8089/api/course'; // Assurez-vous que le port correspond à votre serveur Spring Boot

  constructor(private http: HttpClient) { }

  addCourse(course: Course): Observable<Course> {
    return this.http.post<Course>(`${this.baseUrl}/add`, course);
  }

  getAllCourses(): Observable<Course[]> {
    return this.http.get<Course[]>(`${this.baseUrl}/all`);
  }

  updateCourse(course: Course): Observable<Course> {
    return this.http.put<Course>(`${this.baseUrl}/update`, course);
  }

  getCourseById(id: number): Observable<Course> {
    return this.http.get<Course>(`${this.baseUrl}/get/${id}`);
  }

  deleteCourse(numCourse: number): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/delete/${numCourse}`);
  }
}
