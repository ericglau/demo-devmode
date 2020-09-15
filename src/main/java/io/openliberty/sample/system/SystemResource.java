// tag::copyright[]
/*******************************************************************************
 * Copyright (c) 2017, 2018 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBM Corporation - Initial implementation
 *******************************************************************************/
// end::copyright[]
package io.openliberty.sample.system;

import javax.ws.rs.core.Response;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import javax.enterprise.context.RequestScoped;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.apache.commons.io.IOUtils;
import org.eclipse.microprofile.metrics.annotation.Counted;
import org.eclipse.microprofile.metrics.annotation.Timed;

@RequestScoped
@Path("/properties")
public class SystemResource {

	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Timed(name = "getPropertiesTime", description = "Time needed to get the JVM system properties")
	@Counted(absolute = true, description = "Number of times the JVM system properties are requested")
	public Response getProperties() throws IOException {
		InputStream is = getClass().getClassLoader().getResourceAsStream("file.txt");
		String resourceString = IOUtils.toString(is, StandardCharsets.UTF_8);

		InputStream is2 = getClass().getClassLoader().getResourceAsStream("file2.txt");
		String resourceString2 = IOUtils.toString(is2, StandardCharsets.UTF_8);

	    return Response.ok(resourceString + " " + resourceString2).build();
	}

}
