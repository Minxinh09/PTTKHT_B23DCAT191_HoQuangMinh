package model;

import java.io.Serializable;

public class Category1 implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String categoryCode;
    private String categoryName;
    private String description;

    public Category1() {
    }

    public Category1(int id, String categoryCode, String categoryName, String description) {
        this.id = id;
        this.categoryCode = categoryCode;
        this.categoryName = categoryName;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategoryCode() {
        return categoryCode;
    }

    public void setCategoryCode(String categoryCode) {
        this.categoryCode = categoryCode;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
