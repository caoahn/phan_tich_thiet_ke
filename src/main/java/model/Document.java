/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.List;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class Document {
    private int id;
    private String name;
    private String author;
    private String publishedYear;
    private String description;
    private List<DocumentCopy> copies;

    public Document() {
        this.copies = new ArrayList<>();
    }

    public Document(int id, String name, String author, String publishedYear, String description) {
        this.id = id;
        this.name = name;
        this.author = author;
        this.publishedYear = publishedYear;
        this.description = description;
        this.copies = new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPublishedYear() {
        return publishedYear;
    }

    public void setPublishedYear(String publishedYear) {
        this.publishedYear = publishedYear;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<DocumentCopy> getCopies() {
        return copies;
    }

    public void setCopies(List<DocumentCopy> copies) {
        this.copies = copies;
    }

    @Override
    public String toString() {
        return "Document{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", author='" + author + '\'' +
                ", publishedYear='" + publishedYear + '\'' +
                ", description='" + description + '\'' +
                ", copies=" + (copies != null ? copies.size() : 0) +
                '}';
    }
}
