/**
 * Code generated by Microsoft (R) AutoRest Code Generator.
 * Changes may cause incorrect behavior and will be lost if the code is
 * regenerated.
 */

package com.microsoft.azure.sdk.iot.digitaltwin.service.generated.models;

import java.util.Map;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * The InterfaceModel model.
 */
public class InterfaceModel {
    /**
     * Full name of digital twin interface.
     */
    @JsonProperty(value = "name")
    private String name;

    /**
     * List of all properties in an interface.
     */
    @JsonProperty(value = "properties")
    private Map<String, Property> properties;

    /**
     * Get full name of digital twin interface.
     *
     * @return the name value
     */
    public String name() {
        return this.name;
    }

    /**
     * Set full name of digital twin interface.
     *
     * @param name the name value to set
     * @return the InterfaceModel object itself.
     */
    public InterfaceModel withName(String name) {
        this.name = name;
        return this;
    }

    /**
     * Get list of all properties in an interface.
     *
     * @return the properties value
     */
    public Map<String, Property> properties() {
        return this.properties;
    }

    /**
     * Set list of all properties in an interface.
     *
     * @param properties the properties value to set
     * @return the InterfaceModel object itself.
     */
    public InterfaceModel withProperties(Map<String, Property> properties) {
        this.properties = properties;
        return this;
    }

}