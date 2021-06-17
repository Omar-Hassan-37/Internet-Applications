/*
 * Copyright (c) 2011, 2014, Oracle and/or its affiliates. All rights reserved.
 * ORACLE PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 */

package javafx.scene.effect;

/**
Builder class for javafx.scene.effect.BoxBlur
@see javafx.scene.effect.BoxBlur
@deprecated This class is deprecated and will be removed in the next version
* @since JavaFX 2.0
*/
@javax.annotation.Generated("Generated by javafx.builder.processor.BuilderProcessor")
@Deprecated
public class BoxBlurBuilder<B extends javafx.scene.effect.BoxBlurBuilder<B>> implements javafx.util.Builder<javafx.scene.effect.BoxBlur> {
    protected BoxBlurBuilder() {
    }

    /** Creates a new instance of BoxBlurBuilder. */
    @SuppressWarnings({"deprecation", "rawtypes", "unchecked"})
    public static javafx.scene.effect.BoxBlurBuilder<?> create() {
        return new javafx.scene.effect.BoxBlurBuilder();
    }

    private int __set;
    public void applyTo(javafx.scene.effect.BoxBlur x) {
        int set = __set;
        if ((set & (1 << 0)) != 0) x.setHeight(this.height);
        if ((set & (1 << 1)) != 0) x.setInput(this.input);
        if ((set & (1 << 2)) != 0) x.setIterations(this.iterations);
        if ((set & (1 << 3)) != 0) x.setWidth(this.width);
    }

    private double height;
    /**
    Set the value of the {@link javafx.scene.effect.BoxBlur#getHeight() height} property for the instance constructed by this builder.
    */
    @SuppressWarnings("unchecked")
    public B height(double x) {
        this.height = x;
        __set |= 1 << 0;
        return (B) this;
    }

    private javafx.scene.effect.Effect input;
    /**
    Set the value of the {@link javafx.scene.effect.BoxBlur#getInput() input} property for the instance constructed by this builder.
    */
    @SuppressWarnings("unchecked")
    public B input(javafx.scene.effect.Effect x) {
        this.input = x;
        __set |= 1 << 1;
        return (B) this;
    }

    private int iterations;
    /**
    Set the value of the {@link javafx.scene.effect.BoxBlur#getIterations() iterations} property for the instance constructed by this builder.
    */
    @SuppressWarnings("unchecked")
    public B iterations(int x) {
        this.iterations = x;
        __set |= 1 << 2;
        return (B) this;
    }

    private double width;
    /**
    Set the value of the {@link javafx.scene.effect.BoxBlur#getWidth() width} property for the instance constructed by this builder.
    */
    @SuppressWarnings("unchecked")
    public B width(double x) {
        this.width = x;
        __set |= 1 << 3;
        return (B) this;
    }

    /**
    Make an instance of {@link javafx.scene.effect.BoxBlur} based on the properties set on this builder.
    */
    public javafx.scene.effect.BoxBlur build() {
        javafx.scene.effect.BoxBlur x = new javafx.scene.effect.BoxBlur();
        applyTo(x);
        return x;
    }
}
